import 'package:flutter/material.dart';
import 'package:optimistic_soundz/userlogin.dart';
import 'package:optimistic_soundz/usersignup.dart';

class account extends StatelessWidget {
  const account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountFrame(context);
  }

  Widget AccountFrame(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Account")),
        body: ListView(children: <Widget>[
          Card(
              child: ListTile(
            title: Text('Login'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              //Navigator.push(
              // context, MaterialPageRoute(builder: (context) => PageHome()));
            },
          )),
          Card(
              child: ListTile(
            title: Text('Sign Up'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              // Navigator.push(
              //  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
          )),
        ]));
  }
}
