import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/logic/blocs/posts/post_state.dart';
import 'package:nsks/presentation/posts/screens/post_detail.dart';
import 'package:nsks/presentation/posts/screens/post_list.dart';
import 'package:nsks/presentation/posts/widgets/post_list_redirect.dart';
import 'package:nsks/presentation/widgets/generics/failure.dart';
import 'package:nsks/presentation/widgets/generics/loading_screen.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(listener: (context, state) {
      if (state is PostAccepted) {
        BlocProvider.of<PostBloc>(context).add(GetPosts());
        Flushbar(
          title: "Success",
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.TOP,
          message:
              "Accepted Volunteer Position",
          icon: Icon(
            Icons.check,
            size: 28.0,
            color: COLOR_WHITE,
          ),
          duration: Duration(seconds: 2),
        )..show(context);
      }
    }, builder: (context, state) {
      print(state);
      if (state is PostsObtained) {
        List<Post> posts = state.posts;
        NsksUser user = state.user;
        return PostList(posts: posts, user: user);
      }

      if (state is PostFailure) {
        return NSKSFailure(
          errorMessage: state.error,
          bloc: BlocProvider.of<PhoneAuthenticationBloc>(context),
        );
      }

      if (state is GoToPostDetailPage) {
        return PostDetail(
          post: state.post,
          screen: "PostsPage",
        );
      }

      if (state is GoToPostsPage) {
        return PostPageRedirect();
      }

      return NSKSLoading();
    });
  }
}
