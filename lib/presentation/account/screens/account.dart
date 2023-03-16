import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/account_provider.dart';
import 'package:nsks/data/repositories/account_repository.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/account/account_bloc.dart';
import 'package:nsks/logic/blocs/account/account_event.dart';
import 'package:nsks/logic/blocs/account/account_state.dart';
import 'package:nsks/presentation/account/screens/settings.dart';
import 'package:nsks/presentation/account/widgets/volunteer_listing.dart';
import 'package:nsks/presentation/widgets/generics/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountRepository = new AccountRepository(new AccountProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<AccountBloc>(
        create: (context) => AccountBloc(accountRepository)..add(GetAccount()),
        child: AccountPage(),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountFailure) {
            BlocProvider.of<AccountBloc>(context).add(GetAccount());
            Flushbar(
              title: "Failure",
              backgroundColor: Colors.red,
              flushbarPosition: FlushbarPosition.TOP,
              message: state.message,
              icon: Icon(
                Icons.close,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 2),
            )..show(context);
          }
        },
        builder: (context, state) {
          if (state is AccountRetrieved) {
            return AccountDetail(user: state.user);
          }
          return NSKSLoading();
        },
      )),
    );
  }
}

class AccountDetail extends StatefulWidget {
  final NsksUser user;

  AccountDetail({Key? key, required this.user});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  late int counter;

  double getTotalHours(List<Post> posts) {
    double totalHours = 0;
    for (Post post in posts) {
      totalHours += post.hours;
    }

    return totalHours;
  }

  List<Post> getPostsByVolunteerByDate(List<Post> posts, String filter) {
    List<Post> filteredPosts = [];

    if (filter == "Upcoming") {
      for (Post post in posts) {
        if (DateTime.now().isBefore(DateTime.parse(post.endDate))) {
          filteredPosts.add(post);
        }
      }
    } else {
      for (Post post in posts) {
        if (DateTime.now().isAfter(DateTime.parse(post.endDate))) {
          filteredPosts.add(post);
        }
      }
    }

    return filteredPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              child: Stack(children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/dune-green.png",
                        height: 225,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.grey[50],
                    ),
                  ],
                ),
                Positioned(
                  top: 30,
                  right: 1,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: new EdgeInsets.only(top: 155),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: COLOR_LIGHT_GREEN,
                    backgroundImage:
                        CachedNetworkImageProvider(widget.user.pfpUrl),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    padding: new EdgeInsets.only(top: 260),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.user.isVerified
                            ? Icon(
                                Icons.check,
                                color: COLOR_GREEN,
                                size: 15,
                              )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.user.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: COLOR_BLACK,
                          ),
                        )
                      ],
                    )),
              ]),
            ),
            // SizedBox(height: 10),
            Text(
                "+1 (${widget.user.phoneNumber.substring(2, 5)}) ${widget.user.phoneNumber.substring(5, 8)}-${widget.user.phoneNumber.substring(8, 12)}",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: COLOR_BLUE,
                )),
            SizedBox(height: 8),
            Container(
              width: 125,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: COLOR_GREEN)),
              child: Center(
                child: Text(
                    "Total Hours : ${(getTotalHours(getPostsByVolunteerByDate(widget.user.volunteeredPosts, "Finished")) % 1) == 0 ? getTotalHours(getPostsByVolunteerByDate(widget.user.volunteeredPosts, "Finished")).toInt().toString() : getTotalHours(getPostsByVolunteerByDate(widget.user.volunteeredPosts, "Finished")).toString()}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: COLOR_BLACK,
                    )),
              ),
            ),
            SizedBox(height: 10),
            Stack(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                height: 88,
                width: 329,
                decoration: BoxDecoration(
                    color: COLOR_GREY,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Center(
                  child: Text(
                    widget.user.bio != "" ? widget.user.bio : "No bio yet.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: COLOR_BLACK,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   top: 0,
              //   child: IconButton(
              //       // focusNode: _editButtonFocusNode,
              //       iconSize: 15,
              //       icon: Icon(Icons.edit),
              //       enableFeedback: false,
              //       splashRadius: 0.5,
              //       onPressed: () {}),
              // ),
            ]),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upcoming Events",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: COLOR_BLACK,
                  ),
                ),
              ),
            ),
            getPostsByVolunteerByDate(widget.user.volunteeredPosts, "Upcoming")
                        .length >
                    0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    itemCount: getPostsByVolunteerByDate(
                            widget.user.volunteeredPosts, "Upcoming")
                        .length,
                    itemBuilder: (context, index) {
                      return VolunteerListing(
                          post: getPostsByVolunteerByDate(
                              widget.user.volunteeredPosts, "Upcoming")[index],
                              user: widget.user,);
                    })
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("No upcoming volunteer events.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: COLOR_BLACK,
                            )),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Completed Volunteer Events",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: COLOR_BLACK,
                  ),
                ),
              ),
            ),
            getPostsByVolunteerByDate(widget.user.volunteeredPosts, "Finished")
                        .length >
                    0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0.0),
                    itemCount: getPostsByVolunteerByDate(
                            widget.user.volunteeredPosts, "Finished")
                        .length,
                    itemBuilder: (context, index) {
                      return VolunteerListing(
                          post: getPostsByVolunteerByDate(
                              widget.user.volunteeredPosts, "Finished")[index],
                              user: widget.user,);
                    })
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("You haven't completed any events.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: COLOR_BLACK,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 150,)
          ]),
        ),
      ),
    );
  }
}
