import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/helpers/constants.dart';

String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

class PlayerStatistc extends StatelessWidget {
  final NsksUser user;
  final String placement;
  const PlayerStatistc(
      {Key? key,
      required this.user,
      required this.placement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              placement,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: COLOR_BLACK,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 70, right: 20),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: COLOR_GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: COLOR_WHITE,
                          ),
                        ),
                        Text(
                          removeDecimalZeroFormat(user.hours),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: COLOR_WHITE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: CircleAvatar(
                    backgroundColor: COLOR_GREY,
                    backgroundImage: NetworkImage(user.pfpUrl),
                    radius: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
