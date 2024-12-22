class Task {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}
