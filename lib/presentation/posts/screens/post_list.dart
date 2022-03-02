import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/presentation/posts/create/create_view.dart';
import 'package:nsks/presentation/posts/widgets/post_card.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final NsksUser user;
  const PostList({Key? key, required this.posts, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Home",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: const Color(0xffFFFFFF)),
            ),
          ),
          backgroundColor: COLOR_GREEN,
          actions: user.isStaff
              ? <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 9.5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePageRedirect()));
                        },
                        icon: Icon(
                          Icons.add,
                          color: COLOR_WHITE,
                          size: 30,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ]
              : null,
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<PostBloc>(context).add(GetPosts());
            },
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      height: 44,
                      width: 320,
                      decoration: BoxDecoration(
                        color: const Color(0xffe6e6e6),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Image.asset(
                            "assets/images/search.png",
                            height: 60,
                            width: 60,
                          ),
                          hintText: "Search for events...",
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xff333333),
                          ),
                          suffixIcon: Image.asset(
                            "assets/images/arrow-right-green.png",
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: const Color(0xffe6e6e6),
                      ),
                      child: Icon(Icons.tune_outlined),
                    ),
                  ]),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                      "Here are some recent posts...",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      ],
                    ),
                  ),
                  posts.length > 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(post: posts[index]);
                          })
                      : Center(
                          child: Container(
                            child: Text("No Posts Found"),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 110,
            title: Padding(
              padding: EdgeInsets.only(top: 55),
              child: Text(
                "Home",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: const Color(0xffFFFFFF)),
              ),
            ),
            backgroundColor: COLOR_GREEN,
          ),
          body: Container(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PostBloc>(context).add(GetPosts());
              },
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        height: 44,
                        width: 320,
                        decoration: BoxDecoration(
                          color: const Color(0xffe6e6e6),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Image.asset(
                              "assets/images/search.png",
                              height: 60,
                              width: 60,
                            ),
                            hintText: "Search for posts...",
                            hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xff333333),
                            ),
                            suffixIcon: Image.asset(
                              "assets/images/arrow-right-green.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: const Color(0xffe6e6e6),
                        ),
                        child: Icon(Icons.tune_outlined),
                      ),
                    ]),
                    posts.length > 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return PostCard(post: posts[index]);
                            })
                        : Center(
                            child: Container(
                              child: Text("No Posts Found"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
