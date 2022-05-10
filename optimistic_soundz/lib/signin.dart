// //import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:optimistic_soundz/main.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//     apiKey: "AIzaSyAdUUsl6G7VoY6kxDYhLOBJCX3bOEMeEgs",
//     appId: "1:124024311494:web:df0bc7b9247df21e2851c7",
//     messagingSenderId: "124024311494",
//     projectId: "optimistic-soundz-app",
//   ));
//   runApp(Signup());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PageHome(),
//     );
//   }
// }

// class PageHome extends StatefulWidget {
//   PageHome({Key? key}) : super(key: key);
//   @override
//   _PageHomeState createState() => _PageHomeState();
// }

// class _PageHomeState extends State {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TextField(
//             controller: emailController,
//             decoration: InputDecoration(
//               labelText: "Email",
//             ),
//           ),
//           TextField(
//             controller: passwordController,
//             decoration: InputDecoration(
//               labelText: "Password",
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<AuthenticationService>().signIn(
//                     email: emailController.text.trim(),
//                     password: passwordController.text.trim(),
//                   );
//             },
//             child: Text("Sign in"),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Signup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<AuthenticationService>(
//           create: (_) => AuthenticationService(FirebaseAuth.instance),
//         ),
//         StreamProvider(
//           create: (context) =>
//               context.read<AuthenticationService>().authStateChanges,
//           initialData: null,
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Log in',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: AuthenticationWrapper(),
//       ),
//     );
//   }
// }

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();
//     if (firebaseUser != null) {
//       return PodcastApp();
//     }
//     return MyApp();
//   }
// }

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationService(this._firebaseAuth);

//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<String?> signIn(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return "Signed In";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   Future<String?> signUp(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Signed up";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
// }
