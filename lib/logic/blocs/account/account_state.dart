import 'package:equatable/equatable.dart';
import 'package:nsks/data/models/user.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAccountState extends AccountState {}

class AccountRetrieved extends AccountState {
  final NsksUser user;
  AccountRetrieved({required this.user});
}

class AccountFailure extends AccountState {
  final String message;
  AccountFailure({required this.message});
}
