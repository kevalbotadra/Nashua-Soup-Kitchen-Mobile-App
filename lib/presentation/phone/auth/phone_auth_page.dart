import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_state.dart';
import 'package:nsks/presentation/home/home.dart';
import 'package:nsks/presentation/phone/info/user_info.dart';
import 'package:nsks/presentation/phone/login/phone_login_page.dart';
import 'package:nsks/presentation/splash/splash.dart';
import 'package:nsks/presentation/widgets/generics/green_rounded_button.dart';

class PhoneAuthenticationPage extends StatefulWidget {
  final PhoneAuthRepository phoneAuthRepository;


  PhoneAuthenticationPage({Key? key, required this.phoneAuthRepository}) : super(key: key);

  @override
  _PhoneAuthenticationPageState createState() => _PhoneAuthenticationPageState();
}

class _PhoneAuthenticationPageState extends State<PhoneAuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PhoneAuthenticationBloc, PhoneAuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure){
              ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("An issue occured please try again later."), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
            }
          },
          
          builder: (context, state){
            if (state is UnintializedState){
              return SplashPage();
            } 
            
            if (state is Unauthenticated){
              return PhoneLoginPage(phoneAuthRepository: widget.phoneAuthRepository);
            }

            if (state is StartRegistrationState){
              return UserInfoPage(phoneAuthRepository: widget.phoneAuthRepository);
            }

            if (state is Authenticated){
              return HomePage();
            }

            return SplashPage(); 
          }
        )
      ),
    );
  }
}