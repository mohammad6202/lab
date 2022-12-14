import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab/home.dart';
import 'package:lab/signup.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  static const String screenRoute = "Login_screen";
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text("HOLA")),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xffe46b10),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Color(0xffe46b10),
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe46b10)),
                      child: const Text('Login'),
                      onPressed: () async {
                        try {
                          var authenticationobject = FirebaseAuth.instance;

                          UserCredential myUser = await authenticationobject
                              .signInWithEmailAndPassword(
                                  email: nameController!.text.trim(),
                                  password: passwordController!.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("login successfully")));
                          if (myUser != null) {
                            Navigator.pushNamed(context, Home.screenRoute);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("No user found for that email.")));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Wrong password provided for that user.")));
                          }
                        }

                        print(nameController!.text);
                        print(passwordController!.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
