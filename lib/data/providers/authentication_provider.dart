import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthenticationProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> registerUser({
    required String email,
    required String password,
    required String name,
    required String username,
    required String phoneNumber,
    required bool isStaff,
    required bool isVerified,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    users.doc(user!.uid).set({
      "uid": user.uid,
      "name": name,
      "email" : user.email,
      "username": username,
      "bio" : "",
      "pfpUrl" : "https://robohash.prg/" + user.uid + ".ong",
      "phoneNumber": phoneNumber,
      "isStaff": false,
      "isVerified": false,
      "hours": 0,
      });

    return userCredential.user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
