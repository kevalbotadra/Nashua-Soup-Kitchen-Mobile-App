import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InputType { Regular, Password }

String validate(String value) {
  return "";
}

class InputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputType typeOfInput;
  final String Function(String) validator;
  const InputField(
      {Key? key,
      required this.label,
      this.hintText = "",
      required this.controller,
      required this.typeOfInput,
      this.keyboardType = TextInputType.text,
      this.validator = validate})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            color: const Color(0xffF0F0F0),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w400),
              contentPadding: EdgeInsets.only(left: 20),
            ),
          ),
        ),
      );
  }
}

// TextField(
//             obscureText: !_passwordVisible,
//             textAlign: TextAlign.left,
//             keyboardType: widget.keyboardType,
//             autocorrect: true,
//             controller: widget.controller,
//             decoration: InputDecoration(
//               border: InputBorder.none,asdfa
//               hintText: widget.label,
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 16,
//                   color: const Color(0xff333333),
//                   fontWeight: FontWeight.w400),
//               contentPadding: EdgeInsets.only(top: 10, left: 20, right: 20),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   // Based on passwordVisible state choose the icon
//                   _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                   color: Theme.of(context).primaryColorDark,
//                 ),
//                 onPressed: () {
//                   // Update the state i.e. toogle the state of passwordVisible variable
//                   setState(() {
//                     _passwordVisible = !_passwordVisible;
//                   });
//                 },
//               ),
//             ),
//           ),