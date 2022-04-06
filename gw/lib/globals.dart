library GW.globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var currentUser = FirebaseAuth.instance.currentUser;
