import 'package:flutter/material.dart';
import 'task_detail_screen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _subtaskController = TextEditingController();

  List<String> _subtasks = [];

  void _addSubtask() {
    if (_subtaskController.text.isNotEmpty) {
      setState(() {
        _subtasks.add(_subtaskController.text);
      });
      _subtaskController.clear();
    }
  }

  void _saveTask() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      // Navigate to TaskDetailsScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetailScreen(
            taskTitle: _titleController.text,
            taskDescription: _descriptionController.text,
            startDate: _startDateController.text,
            dueDate: _dueDateController.text,
            repeat: _repeatController.text,
            subtasks: _subtasks,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all required fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView( // Makes the entire screen scrollable if the content overflows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_titleController, 'Task Title'),
            SizedBox(height: 10),
            _buildTextField(_descriptionController, 'Task Description'),
            SizedBox(height: 10),
            _buildTextField(_startDateController, 'Start Date', keyboardType: TextInputType.datetime),
            SizedBox(height: 10),
            _buildTextField(_dueDateController, 'Due Date', keyboardType: TextInputType.datetime),
            SizedBox(height: 10),
            _buildTextField(_repeatController, 'Repeat (Days)', keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField(_subtaskController, 'Subtask'),
            IconButton(
              icon: Icon(Icons.add, color: Colors.blue),
              onPressed: _addSubtask,
            ),
            SizedBox(height: 10),
            Text('Subtasks:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            _subtasks.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: _subtasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_subtasks[index]),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                );
              },
            )
                : Text("No subtasks added yet", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button Color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Save Task', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
