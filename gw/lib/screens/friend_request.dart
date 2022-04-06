import 'package:flutter/material.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        '친구신청 창',
        style: TextStyle(
            fontFamily: "rouf", fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
