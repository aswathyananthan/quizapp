import 'package:flutter/material.dart';
import 'package:quiz_app/utils/firestore.dart';
import 'package:quiz_app/utils/models/questionmodel.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final  _option3Controller = TextEditingController();
  final  _option4Controller = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _answerController.dispose();
    super.dispose();
  }
 final _firestoreServices = FirestoreServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xff5735e0),
        title: const Text(
          "Add Question",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question Field
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: "Enter your question",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Option 1 Field
              TextField(
                controller: _option1Controller,
                decoration: InputDecoration(
                  labelText: "Option 1",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Option 2 Field
              TextField(
                controller: _option2Controller,
                decoration: InputDecoration(
                  labelText: "Option 2",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Option 3 Field
              TextField(
                controller: _option3Controller,
                decoration: InputDecoration(
                  labelText: "Option 3",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Option 4 Field
              TextField(
                controller: _option4Controller,
                decoration: InputDecoration(
                  labelText: "Option 4",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Answer Field
              TextField(
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: "Correct Answer",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Enter the correct answer",
                ),
              ),
              const SizedBox(height: 20),

              // Add Button
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5735e0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async{
                      if(_questionController.text.isNotEmpty){
                        await _firestoreServices.add(Questionmodel(
                          question: _questionController.text, 
                          option1: _option1Controller.text, 
                          option2: _option2Controller.text, 
                          option3: _option3Controller.text, 
                          option4: _option4Controller.text, 
                          answer: _answerController.text));
                          _questionController.clear();
                          _option1Controller.clear();
                          _option2Controller.clear();
                          _option3Controller.clear();
                          _option4Controller.clear();
                          _answerController.clear();
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

