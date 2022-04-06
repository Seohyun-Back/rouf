import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:gw/screens/friend_request.dart';

//import '../globals.dart' as globals;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;

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
      // print("****************************");
      // print("user 정보 가져오기 : ");
      // print(user);
      // final _userData = await FirebaseFirestore.instance
      //     .collection('user')
      //     .doc(user.uid)
      //     .get();
      // print("user data 가져오기");
      // print(_userData);
      // print("****************************");
      if (user != null) {
        loggedUser = user;
        //userData = _userData;
        //print(userData.get(['userName'])!);
        //print(loggedUser!.userName);
        //print(loggedUser!.email);
        //userName = _userData.data()!['userName'];
        // print(userName);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserName() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    return _userData.data()!['userName'];
  }

  Future<String> getUserEmail() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    return await loggedUser!.email.toString();
    //return _userData.data()!['Email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          //title: Text('Main Screen', style: TextStyle(color: Colors.black)),
          leading: Image.asset(
            'images/logo.png',
            //fit: BoxFit.contain,
            height: 50,
          ),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.menu),
          //       color: Colors.black,
          //       onPressed: () {
          //         print('menu button is clicked');
          //       }),
          //   // 로그아웃 버튼. 일단 두고 나중에 옮기자
          //   // IconButton(
          //   //   icon: Icon(
          //   //     Icons.exit_to_app_sharp,
          //   //     color: Colors.black,
          //   //   ),
          //   //   onPressed: () {
          //   //     FirebaseAuth.instance.signOut();
          //   //   },
          //   // )
          // ],
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
                                      //color: Colors.white,
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
            // UserAccountsDrawerHeader(
            //   currentAccountPicture: CircleAvatar(
            //     backgroundImage: AssetImage('assets/images/profile1.jpg'),
            //   ),
            //   accountName: Text('noweeh'),
            //   accountEmail: Text('leehw1011@gmail.com'),
            //   onDetailsPressed: () {
            //     print('arrow is clicked');
            //   },
            //   decoration: BoxDecoration(
            //       color: Colors.green[200],
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(20.0),
            //         bottomRight: Radius.circular(20.0),
            //       )),
            // ),
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
              trailing: Icon(Icons.add),
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
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey[850],
              ),
              title: Text('로그아웃'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                //_authentication.signOut();
                // Navigator.pop(context);
                // Navigator.pop(context);
                print("Logout is clicked");
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Main Screen',
          style: TextStyle(
              fontFamily: "rouf", fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
