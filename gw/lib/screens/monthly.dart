import 'package:flutter/material.dart';

class MonthlyWork extends StatefulWidget {
  const MonthlyWork({Key? key}) : super(key: key);

  @override
  State<MonthlyWork> createState() => _MonthlyWorkState();
}

class _MonthlyWorkState extends State<MonthlyWork> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Monthly Opened"),
    );
  }
}
