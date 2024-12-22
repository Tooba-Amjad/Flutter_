import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),

          // Profile Section
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueAccent),
            title: Text('Profile'),
            subtitle: Text('Update your profile details'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Profile Screen
            },
          ),
          Divider(),

          // Notifications Section
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.orangeAccent),
            title: Text('Notifications'),
            subtitle: Text('Manage notification preferences'),
            trailing: Switch(
              value: true, // Default state for demo
              onChanged: (value) {
                // Handle notification settings toggle
              },
            ),
          ),
          Divider(),

          // Theme Selection Section
          ListTile(
            leading: Icon(Icons.color_lens, color: Colors.purpleAccent),
            title: Text('Theme'),
            subtitle: Text('Light / Dark Mode'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle theme switch or navigate to Theme Settings
            },
          ),
          Divider(),

          // Privacy Policy
          ListTile(
            leading: Icon(Icons.lock, color: Colors.green),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Privacy Policy
            },
          ),
          Divider(),

          // Logout Option
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text('Logout'),
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout action here
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
