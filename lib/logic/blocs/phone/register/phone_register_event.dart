import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class PhoneRegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CompleteRegistrationEvent extends PhoneRegisterEvent {
  String name;
  String username;

  CompleteRegistrationEvent({required this.name, required this.username});
}