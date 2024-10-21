import 'package:flutter/material.dart';
import 'quiz_brain.dart'; // Importing QuizBrain class
import 'quiz_page.dart'; // Import the QuizPage class
import 'QuestionTypeSelectionPage.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto', color: Colors.black87),
        ),
      ),
      home: const CourseSelectionPage(),
    );
  }
}

