import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nsks/data/models/user.dart';

@immutable
abstract class PhoneRegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends PhoneRegisterState {}

class InitialRegisterState extends PhoneRegisterState {}

class SuccessfulRegistration extends PhoneRegisterState {
  NsksUser user;

  SuccessfulRegistration({required this.user});

  NsksUser getUser(){
    return user;
  }
  
  @override
  List<Object> get props => [user];
}

class ExceptionState extends PhoneRegisterState {
  String message;

  ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
