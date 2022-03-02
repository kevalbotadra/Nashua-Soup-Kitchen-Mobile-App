import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> getAccountDetails() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<bool> setBio(String bio) async {
    try {
      User? user = await getAccountDetails();
      await firestore.collection("users").doc(user!.uid).set({
        "bio": bio,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getPostByUid(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("posts").doc(uid).get();

    return snapshot.data();
  }
}
