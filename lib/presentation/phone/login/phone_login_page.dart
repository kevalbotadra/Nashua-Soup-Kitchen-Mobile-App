import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_state.dart';
import 'package:nsks/logic/blocs/phone/login/phone_login_bloc.dart';
import 'package:nsks/logic/blocs/phone/login/phone_login_event.dart';
import 'package:nsks/logic/blocs/phone/login/phone_login_state.dart';
import 'package:nsks/presentation/widgets/generics/green_rounded_button.dart';
import 'package:nsks/presentation/widgets/generics/loading_screen.dart';
import 'package:nsks/presentation/widgets/inputs/input_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneLoginPage extends StatelessWidget {
  final PhoneAuthRepository phoneAuthRepository;
  const PhoneLoginPage({Key? key, required this.phoneAuthRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(phoneAuthRepository),
      child: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, PhoneLoginState>(
      listener: (context, state) {
        if (state is ExceptionState || state is OtpExceptionState) {
          String message = "";
          if (state is ExceptionState) {
            message = state.message;
          } else if (state is OtpExceptionState) {
            message = state.message;
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(message), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      builder: (context, state) {
        print(state);
        if (state is Unauthenticated) {
          return NumberInput(); // NumberInput();
        }

        if (state is OtpSentState || state is OtpExceptionState) {
          return OtpInput(); // OtpInput();
        }

        if (state is LoadingState) {
          return NSKSLoading();
        }

        if (state is LoginCompleteState) {
          BlocProvider.of<PhoneAuthenticationBloc>(context)
              .add(StartRegistration(uuid: state.getUser()!.uid));
        }

        return NumberInput(); // NumberInput();
      },
    );
  }
}

String validateMobile(String value) {
  if (value.length != 10) {
    return 'The number must be 10 digits long.';
  } else {
    return "";
  }
}

class NumberInput extends StatefulWidget {
  const NumberInput({Key? key}) : super(key: key);

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context)
          .add(SendOtpEvent(phoNo: "+1" + _phoneTextController.value.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: Platform.isIOS ? false : true,
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width + 10,
                              height: Platform.isIOS ? 175 : 100, // past-value 100
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/primaryswiggle.png"),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.grey[50],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .31,
                              right: 20.0,
                              left: 20.0),
                          child: Text(
                            "Welcome!",
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: new EdgeInsets.only(
                              top: (MediaQuery.of(context).size.height * .31) +
                                  55,
                              right: 20.0,
                              left: 20.0),
                          child: Text(
                            "Enter your phone number, whether you are a returning user or a new user.",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 33),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: InputField(
                                label: "",
                                hintText: "XXX-XXX-XXXX",
                                controller: _phoneTextController,
                                typeOfInput: InputType.Regular,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return validateMobile(value);
                                }),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: 270,
                          height: 52.0,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: RoundedButton(
                            color: COLOR_GREEN,
                            label: "Authenticate",
                            onPress: _onLoginButtonPressed,
                            useIcon: true,
                            image: "assets/images/arrow-right.png",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/greyswiggle.png"),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.grey[50],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .15,
                              right: 20.0,
                              left: 20.0),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: new EdgeInsets.only(
                              top: (MediaQuery.of(context).size.height * .14) +
                                  55,
                              right: 20.0,
                              left: 20.0),
                          child: Text(
                            "Enter the 6-digit pin sent to your phone.",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 10,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (String pin) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(VerifyOtpEvent(otp: pin));
                        },
                        onChanged: (value) {},
                        validator: (v) {
                          if (v!.length < 6) {
                            return "Please fill the entire 6 digit OTP";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
