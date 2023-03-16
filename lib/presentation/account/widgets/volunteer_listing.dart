import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/presentation/detail/post_detail.dart';

class VolunteerListing extends StatelessWidget {
  final Post post;
  final NsksUser user;

  VolunteerListing({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PostDetailRedirect(post: post, user: user ,screen: "AccountPage")));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(6)),
                  child: Image.network(post.imageUrl,
                      height: 80, width: 100, fit: BoxFit.cover)),
            ),
            Container(
              width: 167,
              height: 80,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(6)),
                color: COLOR_GREY,
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: AutoSizeText(
                  post.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: COLOR_BLACK,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.8)),
                  border: Border.all(
                    color: COLOR_GREEN,
                    width: 1.5,
                  ),
                  color: BACKGROUND_COLOR,
                ),
                child: Center(
                  child: Text(
                    (post.hours % 1) == 0
                        ? post.hours.toInt().toString()
                        : post.hours.toString(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: COLOR_BLACK,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
