import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in_screen.dart';
import 'home_screen.dart';  // Your home screen after sign-in
import 'OnboardingScreen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));  // 3 seconds delay

    // Check if the user is already signed in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Navigate to Home screen if signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),  // Replace with your actual home screen
      );
    } else {
      // Navigate to Onboarding screen if not signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),  // Go to onboarding if new user
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/app_logo.jpg"),  // Add your logo here
            SizedBox(height: 20),
            CircularProgressIndicator(),  // Optional: Show loading indicator
          ],
        ),
      ),
    );
  }
}
