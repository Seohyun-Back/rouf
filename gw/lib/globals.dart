library gw.globals;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

var currentUser = FirebaseAuth.instance.currentUser;

String currentUsername = '';
String currentUid = '';
String currentEmail = '';
String friendUid = '';
String friendName = '';
String friendEmail = '';
int friendNum = 0;

void initGlobals() {
  currentUsername = '';
  currentUid = '';
  currentEmail = '';
  friendUid = '';
  friendName = '';
  friendEmail = '';
  friendNum = 0;
}

List<String> tasks = ["공부", "운동", "잠자기", "일하기", "놀기", "이동", "밥먹기", "직접 추가"];

int statusKey = 8;
