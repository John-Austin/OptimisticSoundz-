import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fire_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CountUpState();
  }
}

class CountUpState extends State<CountUp> {
  int _counter = 0;
  void _incrementup() {
    setState(() {
      _counter += 100;
    });
  }

  void _settozero() {
    setState(() {
      _counter = 0;
    });
  }

  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String? uid = _firebaseAuth.currentUser?.uid.toString();
    //print(uid);
    return Column(
      children: <Widget>[
        const Text(
          'Points: ',
          style: TextStyle(fontSize: 30, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        Center(
            child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData == true) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              print(data);
              //String counter = {data['points']} as String;
              return Text(
                "${data['points']}",
                style: TextStyle(fontSize: 30, color: Colors.white70),
                textAlign: TextAlign.center,
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              print("error");
            }
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          },
        )),
      ],
    );
  }
}
