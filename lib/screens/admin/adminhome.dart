// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:quiz_app/auth.dart';
// import 'package:quiz_app/screens/admin/addq.dart';
// import 'package:quiz_app/screens/admin/users.dart';
// import 'package:quiz_app/screens/admin/veiwquestions.dart';
// import 'package:quiz_app/screens/authenticate/authenticate.dart';

// class Adminhome extends StatefulWidget {
//   Adminhome({super.key});

//   @override
//   State<Adminhome> createState() => _HomeState();
// }

// class _HomeState extends State<Adminhome> {
//   final _authService = AuthService();
//   int _currentIndex = 0;
//   // final _firestoreServices = FirestoreServices();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff5735e0),
//         title: Text(
//           "Hello Admin ",
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           TextButton(
//               onPressed: () async {
//                 await _authService.signOut();
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => Authenticate()));
//               },
//               child: Text("Signout", style: TextStyle(color: Colors.white))),
//         ],
//       ),
//       body: Expanded(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> AddQuestion()));
//               },
//               child: Container(
//                   height: 100,
//                   width: double.infinity,
//                   padding: EdgeInsets.all(30),
//                   margin: EdgeInsets.only(top: 15,left: 15,right: 15),
//                   decoration: BoxDecoration(
//                     color: Color(0xbb5735e0),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         Image.asset("assets/add-file.png"),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           "Add Questions",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewQuestions()));
//               },
//               child: Container(
//                   height: 100,
//                   width: double.infinity,
//                   padding: EdgeInsets.all(30),
//                   margin: EdgeInsets.only(top: 15,left: 15,right: 15),
//                   decoration: BoxDecoration(
//                     color: Color(0xbb5735e0),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         Image.asset("assets/file.png"),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           "Veiw Questions",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//             ),
            
//           ],
//         ),
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.textIn, // Choose animation style
//         items: const [
//           TabItem(
//               icon: Image(image: AssetImage("assets/home.png")), title: "Home"),
//           TabItem(
//               icon: Image(image: AssetImage("assets/bell.png")),
//               title: "Users"),
//         ],
//         initialActiveIndex: _currentIndex, // Set the initially selected tab
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index; // Update selected tab index
//           });
//         },
//         backgroundColor: Color(0xff5735e0),
//         activeColor: Colors.white,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:quiz_app/auth.dart';
import 'package:quiz_app/screens/admin/addq.dart';
import 'package:quiz_app/screens/admin/users.dart';
import 'package:quiz_app/screens/admin/veiwquestions.dart';
import 'package:quiz_app/screens/authenticate/authenticate.dart';

class Adminhome extends StatefulWidget {
  Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  final _authService = AuthService();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Define the pages for each tab
    AdminHomePage(), // Replace with a home page widget if needed
    Users(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5735e0),
        title: Text(
          "Hello Admin ",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()),
                );
              },
              child: Text("Signout", style: TextStyle(color: Colors.white))),
        ],
      ),
      body: _pages[_currentIndex], // Display the current page based on index
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn,
        items: const [
          TabItem(
              icon: Image(image: AssetImage("assets/home.png")), title: "Home"),
          TabItem(
              icon: Image(image: AssetImage("assets/profile.png")), title: "Users"),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color(0xff5735e0),
        activeColor: Colors.white,
      ),
    );
  }
}

// Placeholder for Admin home content (optional)
class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddQuestion()),
            );
          },
          child: Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xbb5735e0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset("assets/add-file.png"),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add Questions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewQuestions()),
            );
          },
          child: Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xbb5735e0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset("assets/file.png"),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "View Questions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
