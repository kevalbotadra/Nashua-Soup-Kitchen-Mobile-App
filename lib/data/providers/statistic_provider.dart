import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getListOfUsers() async {
    List<Map<String, dynamic>> userData = [];

    await firestore.collection("users").get().then((querySnapshot) => {
      querySnapshot.docs.forEach((doc) { 
        userData.add(doc.data());
      })
    });

    return userData;
  }

  Future<Map<String, dynamic>?> getPostByUid(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("posts").doc(uid).get();

    return snapshot.data();
  }

}