import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String screenRoute = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    final uemail = user.email;
    if (uemail.toString().contains("red")) {
      background = Colors.red;
    } else if (uemail.toString().contains("blue")) {
      background = Colors.blue;
    } else if (uemail.toString().contains("green")) {
      background = Colors.green;
    }
  }

  Color? background;
  String userType = '';

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout)),
      ),
      body: Container(
        color: background,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Welcome ",
            ),
            RadioListTile(
                value: 'u',
                groupValue: userType,
                onChanged: (val) {
                  setState(() {
                    userType = val!;
                  });
                }),
            RadioListTile(
                value: 'a',
                groupValue: userType,
                onChanged: (val) {
                  setState(() {
                    userType = val!;
                  });
                })
          ],
        ),
      ),
    );
  }
}
