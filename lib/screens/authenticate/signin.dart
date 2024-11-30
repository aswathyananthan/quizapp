import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/auth.dart';
import 'package:quiz_app/screens/admin/adminhome.dart';
import 'package:quiz_app/screens/user/home.dart';
import 'package:quiz_app/screens/user/userdetails.dart';
import 'package:quiz_app/utils/firestore.dart';

class Signin extends StatefulWidget {
  Signin({super.key, required this.toggleView});
  final void Function() toggleView;

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String? email;
  String? password;
  bool isLoading = false;
  AuthService _authService = AuthService();
  final _firestoreServices = FirestoreServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    if (email == null ||
        password == null ||
        email!.isEmpty ||
        password!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (email == "adminquizapp@gmail.com" && password == "admin123") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Adminhome()),
        );
        return;
      }

      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred during sign in'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                // Logo
                Center(
                  child: Container(
                    height: 200,
                    width: 250,
                    child: Image.asset("assets/logo.jpg"),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 73, 56, 119),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                // Email TextField
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(Icons.email, color: Color(0xff5735e0)),
                  ),
                  onChanged: (value) => email = value,
                ),
                SizedBox(height: 18),
                // Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Color(0xff5735e0)),
                  ),
                  onChanged: (value) => password = value,
                ),
                SizedBox(height: 15),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xff5735e0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : TextButton(
                          onPressed: _signIn,
                          child: Text(
                            "SignIn",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't you have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: widget.toggleView,
                      child: Text(
                        "SignUp",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color(0xff5735e0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/google.png"),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        TextButton(
                            onPressed: () async {
                              setState(() => isLoading = true);
                              final user =
                                  await _authService.signInWithGoogle();
                              print(user!.user!.uid);
                              final userStore = await _firestoreServices
                                  .getUser(user.user!.uid);
                              setState(() => isLoading = false);
                              print(userStore);
                              if (userStore?.exists ?? false) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Userdetails(isUser: false),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "SignIn with Google",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
