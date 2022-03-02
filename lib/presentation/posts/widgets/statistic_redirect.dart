import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/data/providers/statistic_provider.dart';
import 'package:nsks/data/repositories/statistic_repository.dart';
import 'package:nsks/logic/blocs/statistic/statistic_bloc.dart';
import 'package:nsks/logic/blocs/statistic/statistic_event.dart';
import 'package:nsks/presentation/posts/screens/statistic.dart';

class StatisticRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final statisticRepository = new StatisticRepository(new StatisticProvider());

    return Container(
      alignment: Alignment.center,
    child: BlocProvider<StatisticBloc>(
        create: (context) => StatisticBloc(statisticRepository)..add(GetStats()),
        child: StatisticPage(),
      ),
    );
  }
}