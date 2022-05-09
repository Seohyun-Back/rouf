import 'package:flutter/material.dart';
import 'package:gw/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gw/screens/main_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gw/globals.dart' as globals;

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSignupScreen = true;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String userUID = '';
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  int statusKey = 8;
  // late List<String> friends;
  // late List<String> requests;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  Future<void> putGlobals() async {
    final user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    globals.currentUsername = _userData.data()!['userName'];
    globals.currentUid = _userData.data()!['userUID'];
    globals.currentEmail = _userData.data()!['email'];
    print(
        'currentUsername: ${globals.currentUsername} \n currentUserUid: ${globals.currentUid} \n currentUserEmail: ${globals.currentEmail}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              // 배경
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/loginlogo.png'),
                          fit: BoxFit.fill)),
                  // child: Container(
                  //   padding: EdgeInsets.only(top: 90, left: 20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       RichText(
                  //         text: TextSpan(
                  //           text: 'welcome',
                  //           style: TextStyle(
                  //               letterSpacing: 1.0,
                  //               fontSize: 25,
                  //               color: Colors.white),
                  //           children: [
                  //             TextSpan(
                  //               text: isSignupScreen
                  //                   ? ' to Yummy chat!'
                  //                   : ' back',
                  //               style: TextStyle(
                  //                 letterSpacing: 1.0,
                  //                 fontSize: 25,
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 5.0,
                  //       ),
                  //       Text(
                  //         isSignupScreen
                  //             ? 'Signup to continue'
                  //             : 'Signin to continue',
                  //         style: TextStyle(
                  //           letterSpacing: 1.0,
                  //           color: Colors.white,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
              ),
              // 텍스트 폼 필드
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280.0 : 250.0,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5)
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1,
                                  ),
                                ),
                                if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.green,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1,
                                  ),
                                ),
                                if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.green,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter at least 4 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    hintText: 'User name',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    hintText: 'email',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: ValueKey(3),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password must be at least 7 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Please enter a valid address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              )),
                        )
                    ]),
                  ),
                ),
              ),
              // 전송버튼
              AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: isSignupScreen ? 430 : 390,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          if (isSignupScreen) {
                            _tryValidation();
                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                email: userEmail,
                                password: userPassword,
                              );

                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(newUser.user!.uid)
                                  .set({
                                'userUID': newUser.user!.uid,
                                'userName': userName,
                                'email': userEmail,
                                'statusKey': 8,
                              });

                              if (newUser.user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    globals.statusKey = 8;
                                    putGlobals();
                                    return MainScreen();
                                  }),
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please check your email and password'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                            }
                          }
                          if (!isSignupScreen) {
                            _tryValidation();
                            try {
                              globals.statusKey = 8;
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                email: userEmail,
                                password: userPassword,
                              );
                              putGlobals();

                              if (newUser.user != null) {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightGreen,
                                Colors.green,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
//