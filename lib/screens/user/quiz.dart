import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/utils/firestore.dart';
import 'package:lottie/lottie.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _firestoreServices = FirestoreServices();
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  String? _selectedAnswerStatus;
  List<Map<String, dynamic>> _questions = [];
  late Box<String> _completedQuestionsBox;
  late final String userId;

  @override
  void initState() {
    super.initState();
    _initHive();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> _initHive() async {
    _completedQuestionsBox = await Hive.openBox<String>('completed_questions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xff5735e0),
        title: const Text("Quiz Page"),
      ),
      body: StreamBuilder(
        stream: _firestoreServices.read("questions"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No questions available."));
          }

          if (_questions.isEmpty) {
            final allQuestions = snapshot.data!.docs.map((doc) {
              return {
                "id": doc.id,
                "question": doc['question'],
                "options": [
                  doc['option1'],
                  doc['option2'],
                  doc['option3'],
                  doc['option4']
                ],
                "answer": doc['answer'],
              };
            }).toList();

            _questions = allQuestions.where((q) {
              return !_completedQuestionsBox.containsKey('$userId-${q['id']}');
            }).toList();
          }

          if (_questions.isEmpty) {
            return const Center(
                child: Text("Completed all questions wait for update"));
          }

          final currentQuestion = _questions[_currentQuestionIndex];
          final question = currentQuestion['question'];
          final options = currentQuestion['options'];
          final correctAnswer = currentQuestion['answer'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xdd5735e0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...options.map((option) {
                    final isCorrect = _selectedAnswerStatus == "correct" &&
                        _selectedOption == option;
                    final isWrong = _selectedAnswerStatus == "wrong" &&
                        _selectedOption == option;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = option;
                          if (option == correctAnswer) {
                            _selectedAnswerStatus = "correct";
                            _completedQuestionsBox.put(
                                '$userId-${currentQuestion['id']}',
                                currentQuestion['id']);
                            _showCongratsPopup();
                          } else {
                            _selectedAnswerStatus = "wrong";
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.green
                              : isWrong
                                  ? Colors.red
                                  : const Color(0xaa5735e0),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: option,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value;
                                  if (value == correctAnswer) {
                                    _selectedAnswerStatus = "correct";
                                    _completedQuestionsBox.put(
                                        '$userId-${currentQuestion['id']}',
                                        currentQuestion['id']);
                                    _showCongratsPopup();
                                  } else {
                                    _selectedAnswerStatus = "wrong";
                                  }
                                });
                              },
                              activeColor: Colors.black,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                option,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCongratsPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 100,
            width: 100,
            child:
                Lottie.asset('assets/Animation.json', width: 300, height: 300),
          ),
          actions: [
            Center(
                child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xaa5735e0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _nextQuestion();
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ))
          ],
        );
      },
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _selectedAnswerStatus = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Quiz Complete! Great Job!"),
            actions: [
              TextButton(
                onPressed: () {
                   setState(() {
                     Navigator.pop(context);

                   });
                },
                child: const Text("Finish"),
              ),
            ],
          );
        },
      );
    }
  }
}
