import 'package:flutter/material.dart';

class NSKSLoading extends StatefulWidget {
  const NSKSLoading({Key? key}) : super(key: key);

  @override
  _NSKSLoadingState createState() => _NSKSLoadingState();
}

class _NSKSLoadingState extends State<NSKSLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
