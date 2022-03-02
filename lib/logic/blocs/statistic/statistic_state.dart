import 'package:equatable/equatable.dart';
import 'package:nsks/data/models/user.dart';

abstract class StatisticState extends Equatable{
  @override
  List<Object> get props => [];
}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticFailure extends StatisticState {
  final String error;

  StatisticFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ObtainedStats extends StatisticState {
  final List<NsksUser> users;
  ObtainedStats({required this.users});

  @override
  List<Object> get props => [users];
}
