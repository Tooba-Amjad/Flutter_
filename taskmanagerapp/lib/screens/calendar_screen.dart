import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _tasks = {
    DateTime.utc(2024, 12, 12): ['Team Meeting at 10:00 AM', 'Submit Project Report'],
    DateTime.utc(2024, 6, 24): ['Doctor Appointment', 'Prepare Presentation'],
    DateTime.utc(2024, 6, 25): ['Buy Groceries', 'Flutter Study Session'],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; // Initialize selected day to today
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _tasks[day] ?? [];
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 10),

          // Tasks for Selected Day
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final tasksForDay = _tasks[_selectedDay!] ?? [];

    if (tasksForDay.isEmpty) {
      return Center(
        child: Text(
          'No tasks for this day!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasksForDay.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.blueAccent),
            title: Text(
              tasksForDay[index],
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
