import 'package:flutter/material.dart';
import '../models/task.dart';

class PendingTasksScreen extends StatelessWidget {
  final List<Task> pendingTasks = [
    Task(title: 'Project Report', description: 'Prepare final report', dueDate: DateTime.now().add(Duration(days: 2))),
    Task(title: 'Grocery Shopping', description: 'Buy vegetables', dueDate: DateTime.now().add(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pending Tasks')),
      body: ListView.builder(
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          final task = pendingTasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Icon(Icons.pending, color: Colors.orange),
            ),
          );
        },
      ),
    );
  }
}
