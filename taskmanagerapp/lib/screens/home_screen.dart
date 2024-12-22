// home_screen.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanagerapp/screens/profile_screen.dart';

// Importing the new task screens
import 'today_tasks_screen.dart';
import 'pending_tasks_screen.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of Navigation Screens
  final List<Widget> _screens = [
    HomeContent(),
    CalendarScreen(),
    ReportsScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 // Show app bar only when Home tab is selected
          ? AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
      )
          : null, // Null means no app bar for other screens
      body: _screens[_selectedIndex], // Display selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: [

              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey[800]), // Dark grey
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: Colors.grey[800]), // Dark grey
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report, color: Colors.grey[800]), // Dark grey
                label: 'Reports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.grey[800]), // Dark grey
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey[800]), // Dark grey
                label: 'Profile',
              ),
            ],
          )

    );
  }
}

// Main Home Content Code
class HomeContent extends StatelessWidget {
  final String userName = 'John Doe';
  final String profileImageUrl = 'assets/images/profile.jpg';

  final List<Task> tasks = [
    Task(
      title: 'Complete Flutter project',
      description: 'Finish the UI for the task management app.',
      dueDate: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      title: 'Team meeting',
      description: 'Discuss project milestones.',
      dueDate: DateTime.now().add(Duration(days: 1)),
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayTasks = tasks.where((task) =>
    task.dueDate.year == today.year &&
        task.dueDate.month == today.month &&
        task.dueDate.day == today.day).toList();

    final pendingTasks = tasks.where((task) =>
    task.dueDate.isAfter(today) && !task.isCompleted).toList();

    final doneTasks = tasks.where((task) => task.isCompleted).toList();

    double completionPercent = todayTasks.isNotEmpty
        ? doneTasks.length / todayTasks.length
        : 0.0;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(profileImageUrl),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello, $userName',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Circular Progress Indicator
              Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: completionPercent,
                  center: Text(
                    "${(completionPercent * 100).toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 20),
                  ),
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              // Task Overview Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTaskOverviewCard('Done', doneTasks.length, Colors.green),
                  _buildTaskOverviewCard('Pending', pendingTasks.length, Colors.orange),
                  _buildTaskOverviewCard('Upcoming', pendingTasks.length, Colors.blue),
                ],
              ),
              SizedBox(height: 20),

              // Today's Tasks Section
              _buildSectionHeader(
                context,
                'Today\'s Tasks',
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodayTasksScreen())),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

              // Pending Tasks Section
              _buildSectionHeader(
                context,
                'Pending Tasks',
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => PendingTasksScreen())),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: onTap,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildTaskOverviewCard(String title, int count, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Task Model
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
