import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nsks/data/providers/phone_provider.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';
import 'package:nsks/logic/blocs/phone/login/phone_login_event.dart';
import 'package:nsks/logic/blocs/phone/login/phone_login_state.dart';


class LoginBloc extends Bloc<PhoneLoginEvent, PhoneLoginState> {
  final PhoneAuthRepository _phoneAuthRepository;
  late StreamSubscription subscription;

  String verID = "";

  LoginBloc(PhoneAuthRepository phoneAuthRepository)
      : _phoneAuthRepository = phoneAuthRepository, super(InitialLoginState());

  
  @override
  Stream<PhoneLoginState> mapEventToState(
    PhoneLoginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();

      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result =
            await _phoneAuthRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          
          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
      }
    }
  }

  Stream<PhoneLoginEvent> sendOtp(String phoNo) async* {
    StreamController<PhoneLoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _phoneAuthRepository.getUser();
      _phoneAuthRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, int? forceResent) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _phoneAuthRepository.sendOtp(
        phoNo,
        Duration(seconds: 10),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}