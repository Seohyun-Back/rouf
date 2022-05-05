import 'package:flutter/material.dart';
import 'package:gw/globals.dart' as globals;

class AddTask extends StatefulWidget {
  const AddTask(String taskName, {Key? key}) : super(key: key);

  String get taskName => taskName;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String taskName;
  // void _changeName() {
  //   setState(() {
  //     taskName = "";
  //     AddTask(taskName);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        child: Container(
          //margin: new EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListBody(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        //width: 200,
                        //padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(taskName + '\n added!'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //return Container();
  }
}
