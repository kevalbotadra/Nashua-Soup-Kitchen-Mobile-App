import 'package:bloc/bloc.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/repositories/post_repository.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/logic/blocs/posts/post_state.dart';
import 'package:nsks/logic/exceptions/post_exception.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(PostRepository postRepository)
      : _postRepository = postRepository,
        super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is CreatePost) {
      yield* _mapCreatePostToState(event);
    }

    if (event is GetPosts) {
      yield* _mapGetPostsToState(event);
    }

    // if (event is DeletePost) {
    //   yield* _mapDeletePostToState(event);
    // }

    if (event is AcceptPost) {
      yield* _mapAcceptPostToState(event);
    }

    if (event is GetAccount) {
      yield* _mapGetAccountToState(event);
    }

    if (event is NavigateToDetailPage) {
      yield* _mapNavigateToDetailPageToState(event);
    }

    if (event is NavigateToPostsPage) {
      yield* _mapNavigateToPostsPageToState(event);
    }

    if (event is NavigateToSettingsPage){
      yield* _mapNavigateToSettingsPageToState(event);
    }


  }

  Stream<PostState> _mapCreatePostToState(CreatePost event) async* {
    yield PostLoading();
    try {
      await _postRepository.createPost(
          title: event.title,
          body: event.body,
          hours: event.hours,
          startDate: event.startDate,
          startTime: event.startTime,
          endDate: event.endDate,
          endTime: event.endTime,
          imageFile: event.imageFile,
          location: event.location,
          );
      yield PostCreated();
    } on PostException catch (e) {
      yield PostFailure(error: e.message);
    } catch (err) {
      yield PostFailure(error: err.toString());
    }
  }

  Stream<PostState> _mapGetPostsToState(GetPosts event) async* {
    yield PostLoading();
    final posts = await _postRepository.getPosts();
    NsksUser user = await _postRepository.getAccountDetails();
    if (posts != null) {
      yield PostsObtained(posts: posts, user: user);
    } else {
      yield PostFailure(error: 'Something very weird just happened');
    }
    try {} on PostException catch (e) {
      yield PostFailure(error: e.message);
    } catch (err) {
      yield PostFailure(error: err.toString());
    }
  }

  // Stream<PostState> _mapDeletePostToState(DeletePost event) async* {
  //   yield PostLoading();
  //   try {
  //     await _postRepository.deletePost(event.id);
  //     yield PostDeleted();
  //   } on PostException catch (e) {
  //     yield PostFailure(error: e.message);
  //   } catch (err) {
  //     yield PostFailure(error: err.toString());
  //   }
  // }

  Stream<PostState> _mapAcceptPostToState(AcceptPost event) async* {
    yield PostLoading();
    try {
      await _postRepository.acceptPost(event.id);
      yield PostAccepted();
    } on PostException catch (e) {
      yield PostFailure(error: e.message);
    } catch (err) {
      yield PostFailure(error: err.toString());
    }
  }

  Stream<PostState> _mapGetAccountToState(GetAccount event) async* {
    yield PostLoading();
    try {
      NsksUser user = await _postRepository.getAccountDetails();
      yield AccountRetrieved(user: user);
    } on PostException catch (e) {
      yield PostFailure(error: e.message);
    } catch (err) {
      yield PostFailure(error: err.toString());
    }
  }

  Stream<PostState> _mapNavigateToDetailPageToState(
      NavigateToDetailPage event) async* {
    yield PostLoading();
    try {
      Post post = await _postRepository.getPostByUid(event.uid);
      yield GoToPostDetailPage(post: post);
    } catch (e) {
      print(e.toString());
      yield PostFailure(error: "Something unexpected happened.");
    }
    
  }

  Stream<PostState> _mapNavigateToPostsPageToState(
      NavigateToPostsPage event) async* {
    yield GoToPostsPage();
  }

  Stream<PostState> _mapNavigateToSettingsPageToState(
      NavigateToSettingsPage event) async* {
    yield GoToSettingsPage();
  }

  // Stream<PostState> _mapNavigateToOtherAccountPageToState(){

  // }

}
