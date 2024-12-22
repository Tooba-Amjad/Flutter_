import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_in_screen.dart'; // Import your sign-in screen here

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();

  File? _profileImage;
  String? _email;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Load user profile data from Firestore
  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docSnapshot = await _firestore.collection('users').doc(user.uid).get();
    if (docSnapshot.exists) {
      setState(() {
        _email = user.email; // Fetch email from Firebase Authentication
        _userName = docSnapshot.data()?['name'] ?? '';
        final imagePath = docSnapshot.data()?['profileImage'];
        _nameController.text = _userName ?? '';
        if (imagePath != null) {
          _profileImage = File(imagePath);
        }
      });
    }
  }

  // Save user profile data to Firestore
  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final profileData = {
      'name': _nameController.text,
      'profileImage': _profileImage?.path, // Save local image path
    };

    try {
      await _firestore.collection('users').doc(user.uid).set(profileData, SetOptions(merge: true));
      setState(() {
        _userName = _nameController.text;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile updated!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')));
    }
  }

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final localImagePath = '${directory.path}/${pickedFile.name}';
      final savedImage = await File(pickedFile.path).copy(localImagePath);

      setState(() {
        _profileImage = savedImage;
      });

      _saveProfile(); // Save image path to Firestore
    }
  }

  // Show Confirmation Dialog
  Future<void> _showConfirmationDialog(
      {required String title, required String content, required VoidCallback onConfirm}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Clear Cache Functionality
  Future<void> _clearCache() async {
    setState(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cache cleared successfully!')));
    });
  }

  // Clear History Functionality
  Future<void> _clearHistory() async {
    setState(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('History cleared successfully!')));
    });
  }

  // Log Out Functionality
  Future<void> _logOut() async {
    await _auth.signOut(); // Sign out the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out successfully!')),
    );

    // Navigate to SignInScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()), // Replace with your sign-in screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image and Edit Icon
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/default_avatar.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Name Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    _userName ?? 'Your Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _editNameDialog(context);
                  },
                  child: Icon(Icons.edit, color: Colors.blue, size: 18),
                ),
              ],
            ),
            SizedBox(height: 5),

            // Email Section
            Text(
              _email ?? 'No Email Found',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),

            Divider(),

            // Options List
            _buildOptionItem(Icons.favorite, 'Favourites'),
            _buildOptionItem(Icons.download, 'Downloads'),
            _buildOptionItem(Icons.notifications, 'Notifications'),
            _buildOptionItem(Icons.palette, 'Theme'),
            _buildOptionItem(Icons.delete, 'Clear Cache', onTap: () {
              _showConfirmationDialog(
                title: 'Clear Cache',
                content: 'Are you sure you want to clear cache?',
                onConfirm: _clearCache,
              );
            }),
            _buildOptionItem(Icons.history, 'Clear History', onTap: () {
              _showConfirmationDialog(
                title: 'Clear History',
                content: 'Are you sure you want to clear history?',
                onConfirm: _clearHistory,
              );
            }),
            Divider(),
            _buildOptionItem(Icons.logout, 'Log Out', onTap: () {
              _showConfirmationDialog(
                title: 'Log Out',
                content: 'Are you sure you want to log out?',
                onConfirm: _logOut,
              );
            }),
          ],
        ),
      ),
    );
  }

  // Build Options Item
  Widget _buildOptionItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () {},
    );
  }

  // Edit Name Dialog
  Future<void> _editNameDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Enter your name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _saveProfile();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
