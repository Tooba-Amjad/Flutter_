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

class CourseSelectionPage extends StatelessWidget {
  const CourseSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Course', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shadowColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            CourseButton(courseName: 'Web Development'),
            CourseButton(courseName: 'React'),
            CourseButton(courseName: 'Mobile App Development'),
            CourseButton(courseName: 'Machine Learning'),
            CourseButton(courseName: 'AI'),
          ],
        ),
      ),
    );
  }
}

class CourseButton extends StatelessWidget {
  final String courseName;

  const CourseButton({Key? key, required this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        shadowColor: Colors.deepPurpleAccent,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuizTypeSelectionPage(courseName: courseName),
          ),
        );
      },
      child: Text(
        courseName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
