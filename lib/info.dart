import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  static const String screenRoute = "Information";
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot? data;
  Future get(BuildContext context) async {
    data = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: get(context),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Email: ${data!['email']}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('User Type: ${data!['role']}',
                        style: Theme.of(context).textTheme.headline5)
                  ],
                ),
              ),
            );
          })),
    );
  }
}
