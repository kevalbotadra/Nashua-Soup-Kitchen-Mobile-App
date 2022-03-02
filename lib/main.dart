import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/notification/firebase_notification.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_state.dart';
import 'package:nsks/presentation/home/home.dart';
import 'package:nsks/presentation/phone/info/user_info.dart';
import 'package:nsks/presentation/phone/login/phone_login_page.dart';
import 'package:nsks/presentation/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PhoneAuthRepository phoneAuthRepository = PhoneAuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
  runApp(BlocProvider(
    create: (context) => PhoneAuthenticationBloc(phoneAuthRepository)..add(AppStarted()),
    child: MyApp(phoneAuthRepository: phoneAuthRepository),
  ));
}

class MyApp extends StatefulWidget {
  final PhoneAuthRepository _phoneAuthRepository; 

  MyApp({Key? key, required PhoneAuthRepository phoneAuthRepository})
      : _phoneAuthRepository = phoneAuthRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PhoneAuthRepository get userRepository => widget._phoneAuthRepository;

  late FirebaseNotifications firebaseNotifications;

  handleAsync() async {
    await firebaseNotifications.initialize();
    await firebaseNotifications.subscribeToTopic("global");
  }

  @override
  void initState() {
    super.initState();
    firebaseNotifications = FirebaseNotifications();
    handleAsync();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NSKS',
      home: BlocBuilder<PhoneAuthenticationBloc, PhoneAuthenticationState>(
        builder: (context, state) {
          if (state is UnintializedState) {
            return SplashPage();
          } else if (state is Unauthenticated) {
            return PhoneLoginPage(phoneAuthRepository: userRepository);
          } else if (state is Authenticated) {
            return HomePage();
          } else if (state is StartRegistrationState){
            return UserInfoPage(phoneAuthRepository: userRepository);
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}