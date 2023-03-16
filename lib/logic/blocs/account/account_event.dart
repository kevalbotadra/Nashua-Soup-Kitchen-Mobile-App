import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nsks/data/models/user.dart';

@immutable
abstract class AccountEvent extends Equatable {
  AccountEvent([List props = const []]);
  
}

class GetAccount extends AccountEvent {
  @override
  String toString() => 'GetAccount';

  @override
  List<Object> get props => [];
}

