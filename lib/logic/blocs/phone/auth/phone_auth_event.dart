import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nsks/data/models/user.dart';

@immutable
abstract class PhoneAuthenticationEvent extends Equatable {
  PhoneAuthenticationEvent([List props = const []]);
  
}

class AppStarted extends PhoneAuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class StartRegistration extends PhoneAuthenticationEvent {
  final String uuid;

  StartRegistration({required this.uuid});

  @override
  List<Object> get props => [];
}


class LoggedIn extends PhoneAuthenticationEvent {
  final NsksUser? user;

  LoggedIn({required this.user}) : super([user]);

  @override
  List<Object> get props => [user!];
}

class LoggedOut extends PhoneAuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => [];
}

