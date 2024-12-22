import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatelessWidget {
  // Sample Data for Tasks
  final int completedTasks = 12;
  final int pendingTasks = 8;
  final int totalTasks = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                'Task Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Pie Chart for Task Summary
              Center(
                child: Container(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(),
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Bar Chart for Task Progress
              Text(
                'Task Progress (This Week)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 10,
                    barGroups: _buildBarGroups(),
                    titlesData: _buildTitlesData(),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Statistics Summary
              Text(
                'Statistics Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Completed Tasks'),
                  trailing: Text('$completedTasks'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.pending_actions, color: Colors.orange),
                  title: Text('Pending Tasks'),
                  trailing: Text('$pendingTasks'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.assignment, color: Colors.blueAccent),
                  title: Text('Total Tasks'),
                  trailing: Text('$totalTasks'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Pie Chart Sections
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: completedTasks.toDouble(),
        title: '${(completedTasks / totalTasks * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: pendingTasks.toDouble(),
        title: '${(pendingTasks / totalTasks * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
    ];
  }

  // Bar Chart Data
  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(7, (index) {
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
          toY: (index + 1) * 1.5, // Sample progress
          color: Colors.blueAccent,
          width: 15,
          borderRadius: BorderRadius.circular(5),
        )
      ]);
    });
  }

  // Titles for Bar Chart
  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 0:
                return Text('Mon', style: TextStyle(fontSize: 12));
              case 1:
                return Text('Tue', style: TextStyle(fontSize: 12));
              case 2:
                return Text('Wed', style: TextStyle(fontSize: 12));
              case 3:
                return Text('Thu', style: TextStyle(fontSize: 12));
              case 4:
                return Text('Fri', style: TextStyle(fontSize: 12));
              case 5:
                return Text('Sat', style: TextStyle(fontSize: 12));
              case 6:
                return Text('Sun', style: TextStyle(fontSize: 12));
              default:
                return Text('');
            }
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }
}
