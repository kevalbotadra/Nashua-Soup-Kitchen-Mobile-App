import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsks/logic/blocs/phone/auth/phone_auth_event.dart';

class NSKSFailure extends StatelessWidget {
  final String errorMessage;
  final Bloc bloc;
  const NSKSFailure(
      {Key? key, required this.errorMessage, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(errorMessage),
        TextButton(
          style: ButtonStyle(),
          child: Text('Retry'),
          onPressed: () {
            bloc.add(AppStarted());
          },
        )
      ],
    ));
  }
}
