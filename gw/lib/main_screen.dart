import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
//import 'package:flutterfire_ui/auth.dart';
//import 'package:provider/provider.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Text('Main Page '),
            backgroundColor: Colors.white,
            leading: Image.asset('images/logo.png'),
            iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //       Icons.menu,
            //       color: Colors.black,
            //     ),
            //     onPressed: () {
            //       print('menu button clicked!');
            //     },
            //   )
            // ],
            elevation: 0.0,
          ),
        ),
        endDrawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            accountName: Text('Seohyun'),
            accountEmail: Text('lucymail100@gmail.com'),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 158, 221, 160),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('친구 신청'),
            onTap: () async {
              final f = FirebaseFirestore.instance;
              await f
                  .collection('PROFILE')
                  .doc(globals.currentUser?.uid)
                  .set({'username': 'abcd'});
              print("제발");
              print("친구 is clicked");
            },
            //trailing: Icon(Icons.add),          ----------------> 추가하기 버튼 !!!
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('설정'),
            onTap: () {
              print('환경설정합쉬다');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              _authentication.signOut();
              print('Log Out');
            },
          ),
        ])),
        body: Center(
            child: Text('Main Screen ABCDEFGHIJKLMNOQRSTUVWXYZ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'rouf-font',
                ))));
  }
}
