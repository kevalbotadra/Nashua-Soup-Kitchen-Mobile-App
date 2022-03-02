import 'package:equatable/equatable.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';

abstract class PostState extends Equatable{
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostCreated extends PostState {}

class PostsObtained extends PostState {
  final List<Post> posts;
  final NsksUser user;

  PostsObtained({required this.posts, required this.user});

  @override
  List<Object> get props => [posts];
}

class PostDeleted extends PostState {}

class PostAccepted extends PostState {}

class PostFailure extends PostState {
  final String error;

  PostFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AccountRetrieved extends PostState{
  final NsksUser user;

  AccountRetrieved({required this.user});
  
  @override
  List<Object> get props => [user];
}

class GoToPostDetailPage extends PostState {
  final Post post;

  GoToPostDetailPage({required this.post});
  
  @override
  List<Object> get props => [post];
}


class GoToPostsPage extends PostState {}

class GoToSettingsPage extends PostState {}