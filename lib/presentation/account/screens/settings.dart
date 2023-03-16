import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Settings",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: const Color(0xffFFFFFF)),
          ),
        ),
        backgroundColor: COLOR_GREEN,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<PhoneAuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                  child: Text("Log Out",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: COLOR_GREEN))),
            ],
          ),
        ),
      ),
    );
  }
}
