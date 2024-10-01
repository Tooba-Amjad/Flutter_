import 'dart:math'; // Import the Random class from dart:math
import 'package:flutter/material.dart';
import 'package:untitled/screens/challenge_screen.dart'; // Correct path to ChallengeScreen

class SpinScreen extends StatefulWidget {
  final List<String> playerNames;

  SpinScreen({required this.playerNames});

  @override
  _SpinScreenState createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double spinValue = 0;
  int selectedPlayerIndex = 0;
  bool isSpinning = false; // To track if the bottle is currently spinning

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2), // Duration for fast spinning (2 seconds for 2 rounds)
      vsync: this,
    );
  }

  void spinBottle() {
    if (isSpinning) return; // Prevent multiple spins at once
    setState(() {
      isSpinning = true; // Set spinning state to true
    });

    // Generate random spin
    final random = Random();
    int fullSpins = 2; // Fixed to 2 full spins
    double finalSpin = (fullSpins * 360) + (random.nextDouble() * 360); // Add a final random angle

    // Animate the spin
    _controller.forward(from: 0).then((_) {
      setState(() {
        spinValue = finalSpin;

        // Determine the selected player based on spin angle
        double anglePerPlayer = 360 / widget.playerNames.length;
        selectedPlayerIndex = ((finalSpin % 360) ~/ anglePerPlayer).toInt(); // Update index based on spin angle

        isSpinning = false; // Set spinning state back to false after the spin
      });
    });

    // Update the selected player index during the spin
    _controller.addListener(() {
      setState(() {
        spinValue = _controller.value * finalSpin; // Update spinValue based on animation
      });
    });
  }

  void navigateToChallenge() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeScreen(player: widget.playerNames[selectedPlayerIndex]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Bottle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the left player name
                Column(
                  children: [
                    Text(
                      widget.playerNames[0], // Player 1
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: selectedPlayerIndex == 0 ? Colors.blue : Colors.black,
                      ),
                    ),
                    SizedBox(height: 50), // Spacing for the bottle
                  ],
                ),
                // Display the bottle in the center
                GestureDetector(
                  onTap: spinBottle,
                  child: Transform.rotate(
                    angle: spinValue * (pi / 180),
                    child: Image.asset(
                      'assets/bottle.png', // Add your bottle image here
                      width: 200,
                      height: 300,
                    ),
                  ),
                ),
                // Display the right player name
                Column(
                  children: [
                    Text(
                      widget.playerNames[1], // Player 2
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: selectedPlayerIndex == 1 ? Colors.blue : Colors.black,
                      ),
                    ),
                    SizedBox(height: 50), // Spacing for the bottle
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display the selected player's name after spinning
            Text(
              'Selected Player: ${widget.playerNames[selectedPlayerIndex]}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Button to navigate to ChallengeScreen
            ElevatedButton(
              onPressed: isSpinning ? null : navigateToChallenge, // Disable button while spinning
              child: Text('Go to Challenge'),
            ),
          ],
        ),
      ),
    );
  }
}
