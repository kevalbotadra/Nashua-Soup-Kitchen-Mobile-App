import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/register/phone_register_bloc.dart';
import 'package:nsks/logic/blocs/phone/register/phone_register_event.dart';
import 'package:nsks/logic/blocs/phone/register/phone_register_state.dart';
import 'package:nsks/presentation/widgets/generics/green_rounded_button.dart';
import 'package:nsks/presentation/widgets/inputs/input_field.dart';

class UserInfoPage extends StatelessWidget {
  final PhoneAuthRepository phoneAuthRepository;
  const UserInfoPage({Key? key, required this.phoneAuthRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(phoneAuthRepository),
      child: UserDetailForm(),
    );
  }
}

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({Key? key}) : super(key: key);

  @override
  _UserDetailFormState createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, PhoneRegisterState>(
      listener: (context, state) {        
        if (state is ExceptionState) {
          String message = state.message;
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
        if (state is SuccessfulRegistration) {
          print("succesful registration");
          BlocProvider.of<PhoneAuthenticationBloc>(context)
              .add(LoggedIn(user: state.user));
        }

        return UserDetail(); // NumberInput();
      },
    );
  }
}

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _registerButtonPressed() {
      print("here");
      BlocProvider.of<RegisterBloc>(context).add(CompleteRegistrationEvent(
          name: nameController.text, username: usernameController.text));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
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
                            "Almost done?",
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
                            "We need a little more info about you.",
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
                      height: 50,
                    ),
                    InputField(
                      label: "Name",
                      controller: nameController,
                      typeOfInput: InputType.Regular,
                      hintText: "Name",
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InputField(
                      label: "Username",
                      controller: usernameController,
                      typeOfInput: InputType.Regular,
                      hintText: "Username",
                    ),
                    SizedBox(height: 33),
                    Container(
                      width: 270,
                      height: 52.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: RoundedButton(
                        color: const Color(0xff4B4539),
                        label: "Finish",
                        onPress: _registerButtonPressed,
                        useIcon: true,
                        image: "assets/images/arrow-right.png",
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
