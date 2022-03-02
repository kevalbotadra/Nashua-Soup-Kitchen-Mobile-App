import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/helpers/firebase_functions.dart';

class PhoneAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  PhoneAuthRepository(
      FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore)
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<UserCredential> verifyAndLogin(
      String verificationId, String smsCode) async {
    PhoneAuthCredential userCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(userCredential);
  }

  Future<User?> getUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<NsksUser> registerUser({
    required String uid,
    required String name,
    required String username,
    required String? phoneNumber,
  }) async {
    await _firebaseFirestore.collection("users").doc(uid).set({
      "uid": uid,
      "name": name,
      "username": username,
      "phoneNumber": phoneNumber,
      "isVerified": false,
      "isStaff": false,
      "hours": 0,
      "pfpUrl": "https://robohash.org/" + uid + ".png",
      "bio": "",
    });

    return await getCurrentUserFromFirebaseUser(_firebaseAuth.currentUser);
  }
}
