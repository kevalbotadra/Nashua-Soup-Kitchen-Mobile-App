import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/post_provider.dart';
import 'package:nsks/data/repositories/post_repository.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/posts/post_state.dart';

class PostDetailRedirect extends StatelessWidget {
  final Post post;
  final NsksUser user;
  final String screen;
  const PostDetailRedirect(
      {Key? key, required this.post, required this.user, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(new PostRepository(new PostProvider())),
      child: PostDetailPage(post: post, user: user, screen: screen),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final Post post;
  final NsksUser user;
  final String screen;
  const PostDetailPage(
      {Key? key, required this.post, required this.user, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostAccepted) {
          Navigator.pop(context);
          Flushbar(
            title: "Post Accepted",
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            message: "Succesfully Accepted Volunteer Post",
            icon: Icon(
              Icons.check,
              size: 28.0,
              color: COLOR_WHITE,
            ),
            duration: Duration(seconds: 2),
          )..show(context);
          BlocProvider.of<PostBloc>(context).add(GetPosts());
        }
      },
      builder: (context, state) {
        return PostDetail(post: post, user: user, screen: screen);
      },
    );
  }
}

class PostDetail extends StatelessWidget {
  final Post post;
  final NsksUser user;
  final String screen;
  const PostDetail(
      {Key? key, required this.post, required this.user, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onBackButtonPressed() {
      Navigator.pop(context);
    }

    bool isNotVolunteered() {
      for (NsksUser volunteer in post.volunteers) {
        if (volunteer.uid == user.uid) {
          return false;
        }
      }

      return true;
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10.0, top: 40),
                child: Row(
                  children: [
                    SizedBox(
                      height: 35.0,
                      width: 35.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: COLOR_GREEN,
                          child: Icon(Icons.arrow_back),
                          onPressed: _onBackButtonPressed,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      screen == "PostsPage" ? "Postings" : "Account Page",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: COLOR_BLACK,
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context)
                            .add(AcceptPost(id: post.uniqueId));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: COLOR_GREEN),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: COLOR_GREEN,
                        ),
                        child: Center(
                          child: AutoSizeText(
                            isNotVolunteered() ? "Volunteer" : "Volunteered",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: COLOR_WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: AutoSizeText(
                  post.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: COLOR_BLACK,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(post.imageUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            DateFormat('MMM dd, yyyy')
                                .format(DateTime.parse(post.createdAt)),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: COLOR_BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Event Brief: ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: COLOR_GREEN,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        post.body,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: COLOR_BLACK,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Date, Times, and Location: ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: COLOR_GREEN,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                height: 101,
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: COLOR_GREEN),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      DateFormat('EEEE MMM dd, yyyy').format(
                                          DateTime.parse(post.startDate)),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: COLOR_BLACK,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('h:mma')
                                              .format(DateTime.parse(
                                                  post.startDate))
                                              .replaceAll("AM", "am")
                                              .replaceAll("PM", "pm") +
                                          " - " +
                                          DateFormat('h:mma')
                                              .format(
                                                  DateTime.parse(post.endDate))
                                              .replaceAll("AM", "am")
                                              .replaceAll("PM", "pm"),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: COLOR_BLACK,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.room),
                                        Text(
                                          post.location,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: COLOR_BLACK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Current Volunteers: ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: COLOR_GREEN,
                      ),
                    ),
                    post.volunteers.length > 0
                        ? Container(
                            height: 120,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                // padding: EdgeInsets.all(0),
                                itemCount: post.volunteers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: COLOR_LIGHT_GREEN,
                                          backgroundImage: NetworkImage(
                                              post.volunteers[index].pfpUrl),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          post.volunteers[index].name
                                              .split(" ")[0],
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: COLOR_GREEN,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Container(
                              child: Text("No Posts Found"),
                            ),
                          ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
