// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class Signup extends StatefulWidget {
//   Signup({super.key, required this.toggleView});
//   final void Function() toggleView;

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   String? email;
//   String? phonenumber;
//   String? username;
//   String? password;
//   GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
//   bool isLoading = false;

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _register() async {
//     if (_globalKey.currentState?.validate() ?? false) {
//       setState(() {
//         isLoading = true;
//       });

//       try {
//         final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email!,
//           password: password!,
//         );

//         // Optionally update the user's profile with the username
//         await userCredential.user?.updateDisplayName(username);

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Account created successfully!'),
//         ));
//         widget.toggleView(); // Navigate to SignIn
//       } on FirebaseAuthException catch (e) {
//         // Handle errors (e.g., email already in use, weak password)
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(e.message ?? 'An error occurred'),
//         ));
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Expanded(child: ListView(children: [
//       Form(
//         key: _globalKey,
//         child: Column(
//           children: [
//             SizedBox(height: 70),
//             Container(
//               height: 200,
//               width: 250,
//               margin: EdgeInsets.only(left: 80, right: 80),
//               child: Image.asset("assets/logo.jpg"),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 30, right: 30),
//               child: Column(
//                 children: [
//                   Text(
//                     "Create Your Account",
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Color(0xff5735e0),
//                         fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 15),
//                   // Username Field
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Username',
//                       hintText: 'Enter your Username',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       prefixIcon: Icon(Icons.person, color: Color(0xff5735e0)),
//                     ),
//                     validator: (value) => value?.isEmpty == true ? 'Please enter a username' : null,
//                     onChanged: (value) => username = value,
//                   ),
//                   SizedBox(height: 15),
//                   // Email Field
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'Enter your email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       prefixIcon: Icon(Icons.email, color: Color(0xff5735e0)),
//                     ),
//                     validator: (value) =>
//                         value != null && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
//                             ? 'Enter a valid email'
//                             : null,
//                     onChanged: (value) => email = value,
//                   ),
//                   SizedBox(height: 15),
//                   // Phone Number Field
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'Phone number',
//                       hintText: 'Enter your Phone number',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       prefixIcon: Icon(Icons.phone, color: Color(0xff5735e0)),
//                     ),
//                     onChanged: (value) => phonenumber = value,
//                   ),
//                   SizedBox(height: 15),
//                   // Password Field
//                   TextFormField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       hintText: 'Enter your password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       prefixIcon: Icon(Icons.lock, color: Color(0xff5735e0)),
//                     ),
//                     validator: (value) =>
//                         value != null && value.length < 6 ? 'Password must be at least 6 characters' : null,
//                     onChanged: (value) => password = value,
//                   ),
//                   SizedBox(height: 15),
//                   // Sign Up Button
//                   Container(
//                     height: 40,
//                     width: 200,
//                     decoration: BoxDecoration(
//                       color: Color(0xff5735e0),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: isLoading
//                         ? Center(child: CircularProgressIndicator(color: Colors.white))
//                         : TextButton(
//                             onPressed: _register,
//                             child: Text(
//                               "SignUp",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Already have an Account ?", style: TextStyle(fontSize: 14)),
//                       TextButton(
//                         onPressed: widget.toggleView,
//                         child: Text("SignIn", style: TextStyle(fontSize: 14)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),)
//      ] ),),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.toggleView});
  final void Function() toggleView;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? email;
  String? phonenumber;
  String? username;
  String? password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _register() async {
    if (_globalKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        final user = userCredential.user;

        // Update the user's display name
        await user?.updateDisplayName(username);

        // Add user details to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          'username': username,
          'email': email,
          'phonenumber': phonenumber,
          'uid': user?.uid,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );

        widget.toggleView(); // Navigate to SignIn
      } on FirebaseAuthException catch (e) {
        // Handle errors (e.g., email already in use, weak password)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: _globalKey,
            child: Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  height: 200,
                  width: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  child: Image.asset("assets/logo.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff5735e0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Username Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(Icons.person, color: Color(0xff5735e0)),
                        ),
                        validator: (value) => value?.isEmpty == true ? 'Please enter a username' : null,
                        onChanged: (value) => username = value,
                      ),
                      const SizedBox(height: 15),
                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(Icons.email, color: Color(0xff5735e0)),
                        ),
                        validator: (value) => value != null && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
                            ? 'Enter a valid email'
                            : null,
                        onChanged: (value) => email = value,
                      ),
                      const SizedBox(height: 15),
                      // Phone Number Field
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'Enter your Phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(Icons.phone, color: Color(0xff5735e0)),
                        ),
                        onChanged: (value) => phonenumber = value,
                      ),
                      const SizedBox(height: 15),
                      // Password Field
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(Icons.lock, color: Color(0xff5735e0)),
                        ),
                        validator: (value) =>
                            value != null && value.length < 6 ? 'Password must be at least 6 characters' : null,
                        onChanged: (value) => password = value,
                      ),
                      const SizedBox(height: 15),
                      // Sign Up Button
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xff5735e0),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.white))
                            : TextButton(
                                onPressed: _register,
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account ?", style: TextStyle(fontSize: 14)),
                          TextButton(
                            onPressed: widget.toggleView,
                            child: const Text("SignIn", style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

