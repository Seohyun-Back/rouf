import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  //const AddTask({Key? key}) : super(key: key);
  final String taskName;
  const AddTask(this.taskName);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    // Here you direct access using widget
    return Container();
  }
}
