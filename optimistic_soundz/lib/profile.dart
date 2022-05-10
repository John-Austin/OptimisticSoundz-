import 'package:flutter/material.dart';
import 'fire_auth.dart';
import 'validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:optimistic_soundz/main.dart';
import 'package:optimistic_soundz/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userlogin.dart';

//Color background = Color.fromRGBO(18, 22, 64, 1);
Color background = Colors.black87;
//Color background = Colors.white;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Spacer(),
              Text(
                'Email: ${user!.email}',
                style: TextStyle(fontSize: 25, color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData == true) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      print(data);
                      //String counter = {data['points']} as String;
                      return Text(
                        "Username: ${data['username']}",
                        style: TextStyle(fontSize: 25, color: Colors.white70),
                        textAlign: TextAlign.center,
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      print("error");
                      Text('Username: error retrieving username}',
                          style: TextStyle(fontSize: 20, color: textColor),
                          textAlign: TextAlign.center);
                    }
                    return CircularProgressIndicator();
                  }),
              Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: accent,
                    maximumSize: Size.fromWidth(500),
                    // minimumSize: Size.fromWidth(200)
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => Login())));
                  },
                  child: Text("Sign Out",
                      style: TextStyle(fontSize: 25, color: textColor))),
              Spacer(),
            ],
          ));
    } else {
      return Column(
        children: [
          Text(
            "Error, No User Signing, Sign Out and Sign Back In",
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => Login())));
              },
              child: Text("Sign Out", style: TextStyle(color: textColor)))
        ],
      );
    }
  }
}
