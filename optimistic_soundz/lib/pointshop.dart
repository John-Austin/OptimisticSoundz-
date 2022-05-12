import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Color background = Colors.black87;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

Future<void> _incrementOnplay() async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? uid = _firebaseAuth.currentUser?.uid.toString();
  var user = FirebaseFirestore.instance.collection('users').doc(uid);

  user.update({"points": FieldValue.increment(-100)});
}

class PointShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShopList(context);
  }
}

Widget ShopList(BuildContext context) {
  return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: accent,
      ),
      body: ListView(children: <Widget>[
        Card(
            child: ListTile(
          title: Text('QDoba'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            //goes to about pag
          },
        )),
        Card(
            child: ListTile(
          title: Text('Real Chili'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            //goes to account settings
            _incrementOnplay();
          },
        )),
        Card(
            child: ListTile(
          title: Text('Wendys'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _incrementOnplay();
          },
        )),
        Card(
            child: ListTile(
          title: Text('McDonalds'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _incrementOnplay();
          },
        )),
        Card(
            child: ListTile(
          title: Text('Chick Fil A'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _incrementOnplay();
          },
        )),
      ]));
}
