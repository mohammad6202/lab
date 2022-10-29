import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab/info.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String screenRoute = "Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String? uemail;
  getCurrentUser() async {
    final User user = _auth.currentUser!;
    final uid = user.uid;
    uemail = user.email;
  }

  Color background() {
    if (uemail.toString().contains("red")) {
      color = "Red";
      return Colors.red;
    } else if (uemail.toString().contains("blue")) {
      color = "Blue";
      return Colors.blue;
    } else if (uemail.toString().contains("green")) {
      color = "Green";
      return Colors.green;
    }
    color = "User";
    return Colors.amber;
  }

  Map<String, dynamic>? _user = {
    "email": null,
    "role": null,
  };
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future _getUserData(BuildContext context) async {
    try {
      final user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      _user!['email'] = user['Username'];
      _user!['role'] = user['role'];
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
          ),
        ),
      );
    }
  }

  String userType = '';
  String? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("logout successfully")));
            },
            icon: Icon(Icons.logout)),
      ),
      body: Container(
        color: background(),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Welcome Mr. $color ",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 200,
            ),
            Text(
              "User Role",
              style: Theme.of(context).textTheme.headline5,
            ),
            RadioListTile(
                activeColor: Colors.white,
                title: Text(
                  "User",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                value: 'user',
                groupValue: _user!['role'],
                onChanged: (val) {
                  setState(() {
                    _user!['role'] = val;
                  });
                }),
            RadioListTile(
                activeColor: Colors.white,
                title: const Text(
                  "Admin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                value: 'admin',
                groupValue: _user!['role'],
                onChanged: (val) {
                  setState(() {
                    _user!['role'] = val;
                  });
                }),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .set({'role': _user!['role'], 'email': uemail});
                  Navigator.pushNamed(context, Information.screenRoute);
                },
                child: const Text("Your Information"))
          ],
        ),
      ),
    );
  }
}
