import 'package:equatable/equatable.dart';

abstract class PhoneAuthenticationState extends Equatable {
  const PhoneAuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends PhoneAuthenticationState {}

class UnintializedState extends PhoneAuthenticationState {}

class Authenticated extends PhoneAuthenticationState {}

class Unauthenticated extends PhoneAuthenticationState {}

class StartRegistrationState extends PhoneAuthenticationState {}

class Loading extends PhoneAuthenticationState {}

class AuthenticationFailure extends PhoneAuthenticationState {}
