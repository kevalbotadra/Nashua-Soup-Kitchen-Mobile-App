import 'package:equatable/equatable.dart';

abstract class StatisticEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetStats extends StatisticEvent {}