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
import 'package:nsks/presentation/feed/post_list.dart';
import 'package:nsks/presentation/widgets/generics/failure.dart';
import 'package:nsks/presentation/widgets/generics/loading_screen.dart';

class PostHome extends StatefulWidget {
  const PostHome({Key? key}) : super(key: key);

  @override
  _PostHomeState createState() => _PostHomeState();
}

class _PostHomeState extends State<PostHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PostsObtained) {
            List<Post> posts = state.posts;
            NsksUser user = state.user;
            return Feed(posts: posts, user: user);
          }

          if (state is PostFailure) {
            return NSKSFailure(
              errorMessage: state.error,
              bloc: BlocProvider.of<PhoneAuthenticationBloc>(context),
            );
          }

          return NSKSLoading();
        });
  }
}
