import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:nsks/data/models/post.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePost extends PostEvent {
  final String title;
  final String body;
  final double hours;
  final DateTime startDate;
  final TimeOfDay startTime;
  final DateTime endDate;
  final TimeOfDay endTime;
  final File imageFile;
  final String location;
  final String personToNotify;

  CreatePost(
      {required this.title,
      required this.body,
      required this.hours,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime,
      required this.imageFile,
      required this.location, 
      required this.personToNotify});

  @override
  List<Object> get props => [
        title,
        body,
        hours,
        startDate,
        startTime,
        endDate,
        endTime,
        imageFile,
        location,
        personToNotify
      ];
}

class DeletePost extends PostEvent {
  final int id;

  DeletePost({required this.id});

  @override
  List<Object> get props => [id];
}

class AcceptPost extends PostEvent {
  final String id;

  AcceptPost({required this.id});

  @override
  List<Object> get props => [id];
}

class GetPosts extends PostEvent {}

class GetAccount extends PostEvent {}

class NavigateToDetailPage extends PostEvent {
  final String uid;

  NavigateToDetailPage({required this.uid});

  @override
  List<Object> get props => [uid];
}

class NavigateToPostsPage extends PostEvent {}

class NavigateToSettingsPage extends PostEvent {}
