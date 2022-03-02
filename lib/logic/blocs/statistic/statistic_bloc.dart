import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/repositories/statistic_repository.dart';
import 'package:nsks/logic/blocs/statistic/statistic_event.dart';
import 'package:nsks/logic/blocs/statistic/statistic_state.dart';
import 'package:nsks/logic/exceptions/statistic_exception.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final StatisticRepository _statisticRepository;

  StatisticBloc(StatisticRepository statisticRepository)
      : _statisticRepository = statisticRepository,
        super(StatisticInitial());

  @override
  Stream<StatisticState> mapEventToState(StatisticEvent event) async* {
    if (event is GetStats) {
      yield* _mapGetStatsToState(event);
    }
  }

  Stream<StatisticState> _mapGetStatsToState(GetStats event) async* {
    yield StatisticInitial();
    try {
      List<NsksUser> users = await _statisticRepository.getUsersBasedOnHours();
      yield ObtainedStats(users: users);
    } on StatisticException catch (e) {
      yield StatisticFailure(error: e.message);
    } catch (err) {
      yield StatisticFailure(error: err.toString());
    }
  }
}