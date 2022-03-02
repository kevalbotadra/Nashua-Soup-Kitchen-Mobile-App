import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneLoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoginState extends PhoneLoginState {}

class OtpSentState extends PhoneLoginState {}

class LoadingState extends PhoneLoginState {}

class OtpVerifiedState extends PhoneLoginState {}

class LoginCompleteState extends PhoneLoginState {
  User? _firebaseUser;

  LoginCompleteState(this._firebaseUser);

  User? getUser(){
    return _firebaseUser;
  }
  @override
  List<Object> get props => [_firebaseUser!];
}

class ExceptionState extends PhoneLoginState {
  String message;

  ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends PhoneLoginState {
  String message;

  OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
