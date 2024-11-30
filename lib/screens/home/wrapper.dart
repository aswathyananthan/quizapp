import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/authenticate/authenticate.dart';
import 'package:quiz_app/screens/user/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quiz_app/screens/admin/adminhome.dart';
// import 'package:quiz_app/screens/authenticate/authenticate.dart';
// import 'package:quiz_app/screens/user/home.dart';

// class Wrapper extends StatefulWidget {
//   const Wrapper({super.key});

//   @override
//   State<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<User?>();

//     if (user == null) {
//       return const Authenticate();
//     } else if (user.email == "adminquizapp@gmail.com") {
//       return Adminhome();
//     } else {
//       return const Home();
//     }
//   }
// }
