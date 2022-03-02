import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/helpers/firebase_functions.dart';

class PostProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPosts() async {
    List<Map<String, dynamic>> postsMetaData = [];
    await firestore.collection("posts").get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        postsMetaData.add(document.data());
      });
    });

    return postsMetaData;
  }

  Future<void> acceptPost(String postUid) async {
    User? user = await getAccountDetails();
    var list = [user!.uid];
    await firestore
        .collection("posts")
        .doc(postUid)
        .update({"volunteers": FieldValue.arrayUnion(list)});
  }

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

  Future<DocumentSnapshot<Map<String, dynamic>>> createPost({
    required String title,
    required String body,
    required double hours,
    required Timestamp createdAt,
    required Timestamp startDate,
    required Timestamp endDate,
    required File imageFile,
    List<String> tags = const [],
    List<String> volunteers = const [],
    required String location,
  }) async {
    String imageFileUrl = await uploadImageToFirebase(imageFile);

    DocumentReference<Map<String, dynamic>> post =
        await firestore.collection("posts").add({
      "title": title,
      "body": body,
      "hours": hours,
      "createdAt" : createdAt,
      "startDate": startDate,
      "endDate": endDate,
      "imageUrl": imageFileUrl,
      "tags": tags,
      "volunteers": volunteers,
      "location" : location,
    });

    await firestore.collection("posts").doc(post.id).set({
      "uid" : post.id,
    }, SetOptions(merge : true));

    return post.get();
  }
}
