// import 'package:flutter/material.dart';

// class EditProfile extends StatefulWidget {
//   @override
//   EditProfileState createState() => EditProfileState();

// }

// class EditProfileState extends State<EditProfile> {
//   User user = UserPreferences.myUser;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     child: Builder(
//           builder: (context) => Scaffold(
//             appBar: buildAppBar(context),
//             body: ListView(
//               padding: EdgeInsets.symmetric(horizontal: 32),
//               physics: BouncingScrollPhysics(),
//               children: [
//                 ProfileWidget(
//                   imagePath: user.imagePath,
//                   isEdit: true,
//                   onClicked: () async {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'Name',
//                   text: user.name,
//                   onChanged: (name) {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'Email',
//                   text: user.email,
//                   onChanged: (email) {},
//                 ),
//                 const SizedBox(height: 24),
//                 TextFieldWidget(
//                   label: 'About',
//                   text: user.about,
//                   maxLines: 5,
//                   onChanged: (about) {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }
