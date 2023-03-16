import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/providers/post_provider.dart';
import 'package:nsks/data/repositories/post_repository.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/presentation/create/create_view.dart';

class CreatePageRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postRepository = new PostRepository(new PostProvider());

    return Container(
      alignment: Alignment.center,
    child: BlocProvider<PostBloc>(
        create: (context) => PostBloc(postRepository),
        child: CreatePage(),
      ),
    );
  }
}