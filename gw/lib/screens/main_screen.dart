import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:gw/component/add_task.dart';
import 'package:gw/screens/friend_request.dart';
import 'package:gw/screens/monthly.dart';

import '../../globals.dart' as globals;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  List<String> listOfDays = ["월", "화", "수", "목", "금", "토", "일"];

  User? loggedUser;
  //DocumentSnapshot<Map<String, dynamic>>? userData;
  String? userName;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      User user = await _authentication.currentUser!;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserName() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    globals.currentUsername = _userData.data()!['userName'];
    globals.currentUid = _userData.data()!['userUID'];
    globals.currentEmail = _userData.data()!['email'];
    return _userData.data()!['userName'];
  }

  Widget tapableDate() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MonthlyWork();
          }),
        );
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 16,
          ),
          Text(
            selectedDate.year.toString() +
                "/" +
                selectedDate.month.toString() +
                "/" +
                selectedDate.day.toString() +
                " (" +
                listOfDays[selectedDate.weekday - 1] +
                ")",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void addCategory(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("할 일 추가",
              style: TextStyle(
                fontSize: 14,
              )),
          //content: new Text("Alert Dialog body"),
          content: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: Row(children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(
                              'images/TaskIcon/${globals.tasks[i]}.png'),
                          iconSize: 20,
                          onPressed: () {
                            globals.statusKey = i;
                            print(globals.statusKey);
                            //new AddTask();
                          },
                        ),
                        Text(
                          globals.tasks[i],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
              ])),
              Row(
                children: [
                  for (int i = 4; i < 8; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                                'images/TaskIcon/${globals.tasks[i]}.png'),
                            iconSize: 20,
                            onPressed: () {
                              globals.statusKey = i;
                              print(globals.statusKey);
                              //new AddTask();
                            },
                          ),
                          Text(
                            globals.tasks[i],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            ],
          )),
        );
      },
    );
  }

  Future<String> getUserEmail() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    return await loggedUser!.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          leading: Image.asset(
            'images/logo.png',
            height: 50,
          ),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: getUserName(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData == false) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error: ${snapshot.error}',
                                  );
                                } else {
                                  return Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ); //Text(snapshot.data.toString());
                                }
                              }),
                          FutureBuilder(
                              future: getUserEmail(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData == false) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error: ${snapshot.error}',
                                  );
                                } else {
                                  return Text(snapshot.data.toString(),
                                      style: TextStyle(
                                          //color: Colors.white,
                                          ));
                                }
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              )),
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.grey[850],
              ),
              title: Text('친구'),
              onTap: () {
                print("친구 is clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FriendRequest();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('설정'),
              onTap: () {
                print("Setting is clicked");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey[850],
              ),
              title: Text('로그아웃'),
              onTap: () {
                globals.statusKey = 8;
                FirebaseAuth.instance.signOut();
                print("Logout is clicked");
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
        child: Column(children: [
          tapableDate(),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 220,
            width: 330,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: const Text('친구 상태창'),
          ),
          Text(
            "See \n statusKey: ${globals.statusKey}",
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          onPressed: () {
            addCategory(context);
          }),
      // //BUTTON LOCATION
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
