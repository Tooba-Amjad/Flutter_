import 'package:flutter/material.dart';
import 'QuestionTypeSelectionPage.dart'; // Import the QuestionTypeSelectionPage

class CourseSelectionPage extends StatelessWidget {
  const CourseSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {'name': 'Web Development', 'icon': Icons.web},
      {'name': 'React', 'icon': Icons.code},
      {'name': 'Mobile App Development', 'icon': Icons.phone_android},
      {'name': 'Machine Learning', 'icon': Icons.computer},
      {'name': 'AI', 'icon': Icons.android},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Course'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5, // Adjust aspect ratio for better appearance
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0), // Add margin around each box
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20), // Adjust vertical padding
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              onPressed: () {
                // Navigate to QuestionTypeSelectionPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionTypeSelectionPage(courseName: courses[index]['name']),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the contents
                children: [
                  Icon(courses[index]['icon'], color: Colors.white), // Relevant icon
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    courses[index]['name'],
                    style: const TextStyle(fontSize: 20, color: Colors.white), // Updated text style
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
