import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:intl/intl.dart';
import 'package:nsks/presentation/detail/post_detail.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final NsksUser user;
  const PostCard({Key? key, required this.post, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PostDetailRedirect(post: post, user: user, screen: "PostsPage")));
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/app-logo-big.png",
                        height: 20, width: 20),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Nashua Soup Kitchen and Shelter",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: COLOR_BLACK,
                        )),
                  ],
                ),
                Icon(
                  Icons.more_horiz_outlined,
                  color: COLOR_GREEN,
                ),
              ]),
              SizedBox(
                height: 6,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    post.imageUrl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(post.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: COLOR_BLACK,
                      )),
                  Image.asset("assets/images/arrow-right-green.png",
                      height: 20, width: 20)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('MMM dd, yyyy h:mm a')
                    .format(DateTime.parse(post.createdAt)),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: COLOR_BLACK),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
