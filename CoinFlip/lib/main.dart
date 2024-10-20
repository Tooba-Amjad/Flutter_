import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(CoinFlipApp());
}

class CoinFlipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoinFlipHomePage(),
    );
  }
}

class CoinFlipHomePage extends StatefulWidget {
  @override
  _CoinFlipHomePageState createState() => _CoinFlipHomePageState();
}

class _CoinFlipHomePageState extends State<CoinFlipHomePage>
    with SingleTickerProviderStateMixin {
  String coinImage = 'assets/head.png'; // Default coin side
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late Animation<double> _moveAnimation; // Vertical animation
  bool? playerGuess; // true for heads, false for tails
  bool? flipResult; // true for heads, false for tails
  String resultMessage = '';

  int correctGuesses = 0; // Track correct guesses
  int incorrectGuesses = 0; // Track incorrect guesses

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Rotation animation for flipping horizontally
    _flipAnimation = Tween<double>(begin: 0, end: 3 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Movement animation for vertical motion
    _moveAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Randomly pick heads or tails once the flip completes
        bool isHeads = Random().nextBool();
        setState(() {
          coinImage = isHeads ? 'assets/head.png' : 'assets/tail.png';
          flipResult = isHeads;
          checkGuess();
        });
        _controller.reverse(); // Reverse the animation for the next flip
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to start the coin flip animation
  void flipCoin() {
    setState(() {
      resultMessage = '';
    });
    _controller.forward();
  }

  // Function to reset the game state
  void resetGame() {
    setState(() {
      correctGuesses = 0;
      incorrectGuesses = 0;
      resultMessage = '';
      playerGuess = null;
      coinImage = 'assets/head.png'; // Reset to default image
    });
  }

  // Check if the player's guess matches the flip result
  void checkGuess() {
    if (playerGuess == null) {
      resultMessage = 'Please make a guess!';
    } else if (playerGuess == flipResult) {
      setState(() {
        correctGuesses++;
        resultMessage = 'You guessed correctly!';
      });
    } else {
      setState(() {
        incorrectGuesses++;
        resultMessage = 'Oops! You guessed wrong.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D Coin Flip Animation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(0.0, _moveAnimation.value) // Vertical translation
                    ..rotateX(_flipAnimation.value), // Horizontal flip
                  child: Image.asset(
                    coinImage,
                    width: 200,
                    height: 200,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      playerGuess = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: playerGuess == true ? Colors.green : Colors.blue,
                  ),
                  child: Text('Guess Heads'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      playerGuess = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: playerGuess == false ? Colors.green : Colors.blue,
                  ),
                  child: Text('Guess Tails'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: flipCoin,
              child: Text('Flip the Coin'),
            ),
            SizedBox(height: 20),
            Text(
              resultMessage,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              'Correct Guesses: $correctGuesses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Incorrect Guesses: $incorrectGuesses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40), // Add some space before the reset button
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Purple background
              ),
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white), // White text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
