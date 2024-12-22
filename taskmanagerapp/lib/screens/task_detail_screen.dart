import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final String startDate;
  final String dueDate;
  final String repeat;
  final List<String> subtasks;

  TaskDetailScreen({
    required this.taskTitle,
    required this.taskDescription,
    required this.startDate,
    required this.dueDate,
    required this.repeat,
    required this.subtasks,
  });

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  List<bool> _subtaskCompletion = [];

  @override
  void initState() {
    super.initState();
    _subtaskCompletion = List<bool>.filled(widget.subtasks.length, false);
  }

  double get _completionPercent {
    int completedSubtasks = _subtaskCompletion.where((completed) => completed).length;
    return completedSubtasks / widget.subtasks.length;
  }

  void _toggleSubtaskCompletion(int index) {
    setState(() {
      _subtaskCompletion[index] = !_subtaskCompletion[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskTitle),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Details
              _buildDetailRow('Description:', widget.taskDescription),
              _buildDetailRow('Start Date:', widget.startDate),
              _buildDetailRow('Due Date:', widget.dueDate),
              _buildDetailRow('Repeat:', widget.repeat),
              SizedBox(height: 20),

              // Progress Indicator
              Center(
                child: CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 12.0,
                  percent: _completionPercent,
                  center: Text(
                    "${(_completionPercent * 100).toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey[300]!,
                ),
              ),
              SizedBox(height: 20),

              // Subtasks List
              Text(
                'Subtasks:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.subtasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        widget.subtasks[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Checkbox(
                        value: _subtaskCompletion[index],
                        onChanged: (_) => _toggleSubtaskCompletion(index),
                        activeColor: Colors.green,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
