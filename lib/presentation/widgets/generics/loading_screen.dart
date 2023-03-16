import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NSKSLoading extends StatefulWidget {
  const NSKSLoading({Key? key}) : super(key: key);

  @override
  _NSKSLoadingState createState() => _NSKSLoadingState();
}

class _NSKSLoadingState extends State<NSKSLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            SizedBox(
              height: 15,
            ),
            Text("Please wait a moment..", style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
          ]
        ),
      ),
    );
  }
}
