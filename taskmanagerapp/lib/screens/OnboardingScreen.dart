import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'sign_in_screen.dart'; // Import your sign-in screen

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Task Manager",
          body: "Keep track of your tasks and stay organized.",
          image: Image.asset("assets/images/onboarding_1.png"),
        ),
        PageViewModel(
          title: "Set Task Frequency",
          body: "Set recurring tasks with daily, weekly, or custom intervals.",
          image: Image.asset("assets/images/onboarding_2.png"),
        ),
        PageViewModel(
          title: "Track Your Progress",
          body: "Stay on top of your tasks with monthly reports and reminders.",
          image: Image.asset("assets/images/onboarding_3.png"),
        ),
      ],
      onDone: () {
        // Navigate to Sign-In Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
