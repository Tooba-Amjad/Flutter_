import 'package:flutter/material.dart';
import '../models/task.dart';

class TodayTasksScreen extends StatelessWidget {
  final List<Task> todayTasks = [
    Task(title: 'Finish Homework', description: 'Complete math exercises', dueDate: DateTime.now()),
    Task(title: 'Flutter Study', description: 'Learn state management', dueDate: DateTime.now(), isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Today\'s Tasks')),
      body: ListView.builder(
        itemCount: todayTasks.length,
        itemBuilder: (context, index) {
          final task = todayTasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Icon(task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: task.isCompleted ? Colors.green : Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
