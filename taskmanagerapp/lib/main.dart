import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:taskmanagerapp/screens/SplashScreen.dart'; // Import SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Start with SplashScreen
    );
  }
}
