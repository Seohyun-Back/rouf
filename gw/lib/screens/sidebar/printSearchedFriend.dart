import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gw/globals.dart' as globals;

import '../../config/palette.dart';

class printSearchedFriend extends StatefulWidget {
  const printSearchedFriend({Key? key}) : super(key: key);

  @override
  State<printSearchedFriend> createState() => _printSearchedFriendState();
}

class _printSearchedFriendState extends State<printSearchedFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('친구 신청', style: TextStyle(color: Colors.black)),

          leading: IconButton(
            onPressed: () {
              globals.friendName = '';
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),

          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
        ),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.circle,
                  color: Colors.grey[850],
                ),
                // 친구 이메일
                title: Text(globals.friendName),
                // '수락' 버튼으로 바꾸기
                trailing: IconButton(
                    onPressed: () async {
                      print("친구 추가");

                      // DocumentReference docRef = FirebaseFirestore.instance
                      //     .collection('user')
                      //     .doc(globals.friendUid);
                      // DocumentSnapshot doc = await docRef.get();
                      // //List requests = doc.data['requests'];
                      // docRef.update({
                      //   'requests': FieldValue.arrayUnion([globals.currentUid])
                      // });
                      FirebaseFirestore.instance
                          .collection('user/${globals.friendUid}/requests')
                          .doc(globals.currentEmail)
                          .set({
                        'uid': globals.currentUid,
                        'name': globals.currentUsername,
                        'email': globals.currentEmail,
                      });

                      globals.friendName = '';
                      Navigator.pop(context);
                      // 목록에서 해당 data 사라지게
                    },
                    icon: Icon(Icons.add)),
              )
            ],
          )),
    );
  }
}
