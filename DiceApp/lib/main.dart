import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceWithStateful(),
    );
  }
}

class DiceWithStateful extends StatefulWidget {
  @override
  State<DiceWithStateful> createState() => _DiceWithStatefulState();
}

class _DiceWithStatefulState extends State<DiceWithStateful> {
  int playerTurn = 0; // Current player's turn
  List<int> playersScores = []; // Scores for selected players
  List<int> dices = []; // Values of dices
  List<String> playerNames = ['Maliha', 'Ayesha', 'Rimsha', 'Mehreen']; // Names of players
  int targetScore = 0; // Target score to win
  bool gameStarted = false; // Flag to track whether the game has started or not
  List<bool> selectedPlayers = [false, false, false, false]; // Selection state for players

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dice App')),
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: gameStarted ? buildGameContent() : buildPlayerSelection(),
      ),
    );
  }

  Widget buildPlayerSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Select Players', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: playerNames.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(playerNames[index], style: TextStyle(fontSize: 18)),
                value: selectedPlayers[index],
                onChanged: (bool? value) {
                  setState(() {
                    selectedPlayers[index] = value ?? false;
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            setState(() {
              // Reset scores and dices based on selected players
              playersScores = selectedPlayers
                  .asMap()
                  .entries
                  .where((entry) => entry.value)
                  .map((entry) => 0)
                  .toList();
              dices = List.filled(playersScores.length, 1);
              gameStarted = true;
              playerTurn = 0;
            });
          },
          child: Text('Start Game'),
        ),
      ],
    );
  }

  Widget buildGameContent() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < (playersScores.length / 2).ceil(); i++)
                    Column(
                      children: [
                        for (int j = 0; j < 2; j++)
                          if ((i * 2 + j) < playersScores.length) // Check bounds
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${playerNames[i * 2 + j]}: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Column(
                                  children: [
                                    Text('${dices[i * 2 + j]}', style: TextStyle(fontSize: 24)),
                                    SizedBox(height: 10),
                                    buildDice(i * 2 + j),
                                  ],
                                ),
                              ],
                            ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text('Player ${playerTurn + 1}\'s turn', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Target Score',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                onChanged: (value) {
                  setState(() {
                    targetScore = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: targetScore > 0
                    ? () {
                  // Toss to decide player turn and start the game
                  setState(() {
                    playerTurn = Random().nextInt(playersScores.length);
                    gameStarted = true;
                  });
                }
                    : null,
                child: Text('Toss and Start Game'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: gameStarted
                    ? () {
                  setState(() {
                    // Reset the game
                    playerTurn = 0;
                    playersScores = List.filled(selectedPlayers.where((s) => s).length, 0);
                    dices = List.filled(playersScores.length, 1);
                    targetScore = 0;
                    gameStarted = false;
                    selectedPlayers = [false, false, false, false]; // Reset selections
                  });
                }
                    : null,
                child: Text('Reset Game'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scoreboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: playersScores.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(
                          '${playerNames[index]}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${playersScores[index]}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              if (playersScores.isNotEmpty)
                Text(
                  'Winner: ${playerNames[playersScores.indexOf(playersScores.reduce(max))]}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector buildDice(int index) {
    return GestureDetector(
      onTap: gameStarted && playerTurn == index
          ? () {
        setState(() {
          // Roll the dice
          dices[index] = Random().nextInt(6) + 1;
          // Add the number on the dice to the player's score
          playersScores[index] += dices[index];
          // Move to the next player
          playerTurn = (playerTurn + 1) % playersScores.length;
          if (playersScores[playerTurn] >= targetScore) {
            _showWinnerDialog(playerTurn);
          }
        });
      }
          : null,
      child: Image.asset(
        'images/d${dices[index]}.png',
        height: dices[index] == 6 ? 100 : 80, // Make dice bigger if it shows 6
        width: dices[index] == 6 ? 100 : 80, // Make dice bigger if it shows 6
      ),
    );
  }

  void _showWinnerDialog(int winnerIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner'),
          content: Text('${playerNames[winnerIndex]} wins!', style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
