import 'package:flutter/material.dart';
import 'fire_auth.dart';
import 'validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimistic_soundz/main.dart';
import 'package:optimistic_soundz/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color background = Colors.black87;
//Color background = Colors.white;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusUsername = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: accent,
          title: Text("Sign Up Page"),
        ),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('images/os_logo.jpg')),
                ),
              ),
              Padding(padding: const EdgeInsets.all(6)),
              Form(
                key: _registerFormKey,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter a unique username',
                    ),
                    controller: _usernameTextController,
                    focusNode: _focusUsername,
                    validator: (value) => Validator.validateName(name: value!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) =>
                        Validator.validateEmail(email: value!),
                  ),
                  Padding(padding: const EdgeInsets.all(6)),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter a password with at least 6 characters',
                    ),
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) =>
                        Validator.validatePassword(password: value!),
                  ),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(primary: accent),
                        child: Text("Sign Up",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_registerFormKey.currentState!.validate()) {
                            User? user =
                                await FireAuth.registerUsingEmailPassword(
                              name: _usernameTextController.text,
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                            );

                            if (user != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()
                                    //ProfilePage(user: user),
                                    ),
                                ModalRoute.withName('/'),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ]),
                ]),
              ),
            ],
          ),
        ));
  }
}
