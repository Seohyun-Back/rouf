import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutterfire_ui/auth.dart';

import 'package:gw/screens/main_screen.dart';
import 'package:gw/screens/login_screen.dart';

const MaterialColor primaryGreen = MaterialColor(
  _greenPrimaryValue,
  <int, Color>{
    50: Color(0xFF47992A),
    100: Color(0xFF47992A),
    200: Color(0xFF47992A),
    300: Color(0xFF47992A),
    400: Color(0xFF47992A),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF47992A),
    700: Color(0xFF47992A),
    800: Color(0xFF47992A),
    900: Color(0xFF47992A),
  },
);
const int _greenPrimaryValue = 0xFF47992A;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //use firebase auth
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryGreen,
        fontFamily: 'rouf-font',
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}

// class MyPage extends StatelessWidget {
//   const MyPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           child: Center(
//             child: Authentication(),
//           ),
//         )
//         // Authentication(),
//         );
//   }
// }

// Widget logo() {
//   return Image.asset('assets/logo.png', width: 150);
// }

// class Authentication extends StatelessWidget {
//   const Authentication({Key? key}) : super(key: key);

//   get builder => null;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return SignInScreen(
//             headerBuilder: (context, constraints, _) {
//               return Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: AspectRatio(
//                   aspectRatio: 1,
//                   child: Image.asset('images/logo.png', width: 150),
//                 ),
//               );
//             },
//             providerConfigs: [EmailProviderConfiguration()],
//           );
//         }
//         return MainScreen();
//       },
//     );
//   }
// }