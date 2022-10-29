import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab/info.dart';
import 'package:lab/signup.dart';

import 'firebase_options.dart';
import 'home.dart';
import 'logn_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Home.screenRoute: (context) => Home(),
        Login_screen.screenRoute: ((context) => Login_screen()),
        SignUpPage.screenRoute: ((context) => SignUpPage()),
        Information.screenRoute: ((context) => Information()),
      },
      home: handleAuthState(),
    );
  }
}

handleAuthState() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const Login_screen();
        }
      });
}
