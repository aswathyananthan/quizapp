
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/utils/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompletedQuestionsPage extends StatelessWidget {
  final _firestoreServices = FirestoreServices();

  CompletedQuestionsPage({super.key});

  Future<List<Map<String, dynamic>>> _getCompletedQuestions() async {
    final userId = FirebaseAuth.instance.currentUser!.uid; 
    final completedQuestionsBox = Hive.box<String>('completed_questions');
    
    
    final userCompletedQuestionIds = completedQuestionsBox.keys
        .where((key) => key.toString().startsWith('$userId-'))
        .map((key) => key.toString().split('-').last)
        .toList();

    if (userCompletedQuestionIds.isEmpty) {
      return [];
    }
    final completedQuestions = await _firestoreServices.read("questions").first;
    final completedDetails = completedQuestions.docs
        .where((doc) => userCompletedQuestionIds.contains(doc.id))
        .map((doc) {
          return {
            "question": doc["question"],
            "answer": doc["answer"],
          };
        })
        .toList();

    return completedDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attended Questions"),
        backgroundColor: const Color(0xff5735e0),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getCompletedQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No questions attended yet."));
          }

          final completedQuestions = snapshot.data!;
          return ListView.builder(
            itemCount: completedQuestions.length,
            itemBuilder: (context, index) {
              final question = completedQuestions[index];
              return ListTile(
                title: Text(
                  question["question"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Answer: ${question["answer"]}"),
              );
            },
          );
        },
      ),
    );
  }
}
