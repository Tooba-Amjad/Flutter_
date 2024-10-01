import 'dart:math';  // <-- Import the Random class from dart:math
import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  final String player;

  ChallengeScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Predefined challenges
    final challenges = [
      'Sing a song',
      'Do 10 push-ups',
      'Dance for 30 seconds',
      'Tell a funny joke',
      'Answer a trivia question',
    ];

    // Randomly selecting a challenge
    final challenge = challenges[Random().nextInt(challenges.length)];

    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge for $player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Challenge: $challenge',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Spin'),
            ),
          ],
        ),
      ),
    );
  }
}
