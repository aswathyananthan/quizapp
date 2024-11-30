import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/auth.dart';
import 'package:quiz_app/screens/authenticate/authenticate.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:quiz_app/screens/user/completed.dart';
import 'package:quiz_app/screens/user/quiz.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();
  int _currentIndex = 0; 

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    return Scaffold(
      drawer: Drawer(
        elevation: 2,
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              leading: user != null
                  ? Container(
                      margin: EdgeInsets.all(5),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: user.photoURL != null
                              ? Image.network(user.photoURL!)
                              : const Icon(Icons.account_circle, size: 40),
                        ),
                      ),
                    )
                  : const SizedBox(),
              title: Text(user?.displayName ?? "Home"),
            ),
            ListTile(
              onTap: () async {
                try {
                  await _authService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Authenticate()),
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error signing out: $e')),
                  );
                }
              },
              leading: Icon(Icons.logout),
              title: Text(
                "Signout",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff5735e0),
        leading: user != null
            ? Container(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: user.photoURL != null
                        ? Image.network(user.photoURL!)
                        : const Icon(Icons.account_circle, size: 40),
                  ),
                ),
              )
            : const SizedBox(),
        title: const Text(
          "Quiz Time",
          style: TextStyle(color: Colors.white),
        ),
        
      ),
      body: IndexedStack(
        index: _currentIndex, 
        children: [
          ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => QuizPage()));
                },
                child: Container(
                    height: 400,
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Color(0xbb5735e0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/quiz.png"),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            " Start Quiz",
                            style: TextStyle(
                              color: Colors.white,
                              
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
          CompletedQuestionsPage(), 
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn, // Choose animation style
        items: const [
          TabItem(icon: Image(image: AssetImage("assets/tasks.png")), title: "Upcoming Tasks"),
          TabItem(icon: Image(image: AssetImage("assets/completed.png")), title: "Completed"),
        ],
        initialActiveIndex: _currentIndex, // Set the initially selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected tab index
          });
        },
        backgroundColor: Color(0xff5735e0),
        activeColor: Colors.white,
      ),
    );
  }
}

