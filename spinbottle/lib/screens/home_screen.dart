import 'package:flutter/material.dart';
import 'spin_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> playerNames = List.generate(10, (_) => '');
  int playerCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Bottle'),
      ),
      body: Column(
        children: [
          Text('Enter Player Names:'),
          ...List.generate(playerCount, (index) {
            return TextField(
              onChanged: (value) {
                playerNames[index] = value;
              },
              decoration: InputDecoration(
                labelText: 'Player ${index + 1}',
              ),
            );
          }),
          ElevatedButton(
            onPressed: () {
              // Navigate to spin screen with player names
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpinScreen(playerNames: playerNames),
                ),
              );
            },
            child: Text('Start Spinning'),
          ),
        ],
      ),
    );
  }
}
