import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String label;
  final void Function()? onPress;
  final bool useIcon;
  final String image;
  const RoundedButton(
      {Key? key,
      required this.color,
      required this.label,
      required this.onPress,
      required this.useIcon,
      this.image = "NO IMAGE"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useIcon == true
        ? Container(
            width: 270,
            height: 52.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: GestureDetector(
              onTap: onPress,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Image.asset("assets/images/arrow-right.png")
                  ],
                ),
              ),
            ),
          )
        : Container(
            width: 270,
            height: 52.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: GestureDetector(
              onTap: onPress,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this.label,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
