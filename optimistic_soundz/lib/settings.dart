import 'package:flutter/material.dart';
import 'package:optimistic_soundz/about.dart';
import 'package:optimistic_soundz/account.dart';
import 'package:optimistic_soundz/audio.dart';
import 'package:optimistic_soundz/generalsettings.dart';
import 'package:optimistic_soundz/profile.dart';
import 'package:optimistic_soundz/socialsettings.dart';
import 'package:optimistic_soundz/userlogin.dart';

void main() => runApp(Settings());

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsList(context);
  }
}

/*class Mainlayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsList(context);
  }
}*/

Widget SettingsList(BuildContext context) {
  return ListView(children: <Widget>[
    // ListTile(
    //     // leading: CircleAvatar(
    //     //   backgroundImage: Icon(Icons.person_sharp),
    //     // ),
    //     // title: Text('View Profile'),
    //     // onTap() {
    //     //     //goes to user profile
    //     // },
    //     ),
    Card(
        child: ListTile(
      title: Text('About'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        //goes to about pag
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => About()));
      },
    )),
    Card(
        child: ListTile(
      title: Text('Account'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        //goes to account settings
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
    )),
    Card(
        child: ListTile(
      title: Text('Audio'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => audio()));
      },
    )),
    Card(
        child: ListTile(
      title: Text('General'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => General_Settings()));
      },
    )),
    Card(
        child: ListTile(
      title: Text('Social'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Social()));
      },
    )),
  ]);
}
