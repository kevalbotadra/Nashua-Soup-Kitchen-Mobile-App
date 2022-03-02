import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneLoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends PhoneLoginEvent {
  String phoNo;

  SendOtpEvent({required this.phoNo});
}

class AppStartEvent extends PhoneLoginEvent {}

class VerifyOtpEvent extends PhoneLoginEvent {
  String otp;

  VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends PhoneLoginEvent {}

class OtpSendEvent extends PhoneLoginEvent {}

class LoginCompleteEvent extends PhoneLoginEvent {
  final User? firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends PhoneLoginEvent {
  String message;

  LoginExceptionEvent(this.message);
}