import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth.dart';
import 'package:quiz_app/screens/home/wrapper.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/adapters.dart';


void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().userStatus,
      initialData: null,
      catchError: (context, error) {
        print(error);
        return null;
      },
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}