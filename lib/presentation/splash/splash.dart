import 'package:flutter/material.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: COLOR_GREEN,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nashua Soup Kitchen", style: GoogleFonts.poppins(
              color: COLOR_WHITE,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }
}