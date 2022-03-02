import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/account_provider.dart';
import 'package:nsks/helpers/firebase_functions.dart';

class AccountRepository {
  final AccountProvider _accountProvider;

  AccountRepository(this._accountProvider);

  Future<NsksUser> getAccountDetails() async {
    User? userInfo = await _accountProvider.getAccountDetails();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentReference doc = users.doc(userInfo!.uid);
    DocumentSnapshot snapshot = await doc.get();

    List<Post> volunteerPosts = await getPostsbyVolunteer(snapshot["uid"]);
    
    NsksUser finalUser = NsksUser.fullFromSnapshot(snapshot, volunteerPosts);

    return finalUser;
  }

  Future<void> setNewBio(String bio) async {
    await _accountProvider.setBio(bio);
  }

  Future<Post> getPostByUid(String uid) async {
    List<NsksUser> volunteers = [];
    Map<String, dynamic>? doc = await _accountProvider.getPostByUid(uid);
    List uidList = doc!["volunteers"];
    for (String uid in uidList) {
      NsksUser user = await getAnyUserFromFirebaseUserUid(uid);
      volunteers.add(user);
    }
    return Post.fromMap(doc, volunteers);
  }
}