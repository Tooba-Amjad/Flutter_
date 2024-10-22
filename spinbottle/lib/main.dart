import 'package:flutter/material.dart';
import 'dart:math';
<<<<<<< HEAD
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(SpinTheBottleApp());
}

class SpinTheBottleApp extends StatelessWidget {
=======
import 'package:untitled/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
>>>>>>> 1a312d654217a5b714ecfe9b3a113e7fee436e98
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spin the Bottle',
      theme: ThemeData(
<<<<<<< HEAD
        primarySwatch: Colors.purple,
      ),
      home: StartGamePage(),
    );
  }
}

class StartGamePage extends StatefulWidget {
  @override
  _StartGamePageState createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  int _numPlayers = 2; // Default number of players
  List<File?> _playerImages = List.filled(10, null); // List to store player images
  List<String> _playerNames = List.filled(10, ''); // List to store player names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Bottle Game'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Dropdown to select number of players
              DropdownButton<int>(
                value: _numPlayers,
                items: List.generate(10, (index) => index + 1).map((i) {
                  return DropdownMenuItem<int>(
                    value: i,
                    child: Text('$i Players'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _numPlayers = value!;
                    _playerImages = List.filled(_numPlayers, null);
                    _playerNames = List.filled(_numPlayers, '');
                  });
                },
              ),
              SizedBox(height: 20),

              // Input fields for player images and names
              for (int i = 0; i < _numPlayers; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(i),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _playerImages[i] != null
                              ? FileImage(_playerImages[i]!)
                              : null,
                          child: _playerImages[i] == null
                              ? Icon(Icons.add, size: 30)
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Text field for player name
                      TextField(
                        onChanged: (text) {
                          _playerNames[i] = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Player ${i + 1} Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Filter the entered names and images, excluding empty fields
                  List<String> playerNames = _playerNames
                      .where((name) => name.isNotEmpty)
                      .toList();
                  List<File?> playerImages = _playerImages
                      .where((image) => image != null)
                      .toList();

                  if (playerNames.length == _numPlayers &&
                      playerImages.length == _numPlayers) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpinBottlePage(
                            playerImages: playerImages,
                            playerNames: playerNames,
                          )),
                    );
                  } else {
                    // Show an alert if not all names and images are provided
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Incomplete Information'),
                        content: Text('Please provide names and images for all players.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Start the Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to pick an image
  Future<void> _pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _playerImages[index] = File(pickedFile.path);
      });
    }
  }
}

class SpinBottlePage extends StatefulWidget {
  final List<File?> playerImages;
  final List<String> playerNames;

  SpinBottlePage({required this.playerImages, required this.playerNames});

  @override
  _SpinBottlePageState createState() => _SpinBottlePageState();
}

class _SpinBottlePageState extends State<SpinBottlePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0.0;
  double _targetAngle = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _controller.addListener(() {
      setState(() {
        _angle = _controller.value * _targetAngle;
      });
    });
  }

  void _spinBottle() {
    final random = Random();
    setState(() {
      _targetAngle = 2 * pi * (3 + random.nextDouble() * 4); // Spin randomness
      _controller.forward(from: 0.0).then((value) {
        int selectedPlayer = _getSelectedPlayer();
        _showChallenge(selectedPlayer);
      });
    });
  }

  int _getSelectedPlayer() {
    double anglePerPlayer = 2 * pi / widget.playerImages.length;
    double normalizedAngle = _angle % (2 * pi);
    int selectedPlayer =
    ((normalizedAngle / anglePerPlayer) % widget.playerImages.length)
        .floor();
    return selectedPlayer;
  }

  void _showChallenge(int selectedPlayer) {
    String playerName = widget.playerNames[selectedPlayer];
    File? playerImage = widget.playerImages[selectedPlayer];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Challenge for $playerName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (playerImage != null)
                Image.file(
                  playerImage,
                  width: 100,
                  height: 100,
                ),
              SizedBox(height: 10),
              Text('It\'s your turn to complete the challenge!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
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
        title: Text('Spin the Bottle Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (int i = 0; i < widget.playerImages.length; i++)
                    Transform.rotate(
                      angle: (2 * pi * i) / widget.playerImages.length,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                          Colors.primaries[i % Colors.primaries.length],
                          backgroundImage: widget.playerImages[i] != null
                              ? FileImage(widget.playerImages[i]!)
                              : null,
                          child: widget.playerImages[i] == null
                              ? Icon(Icons.person, size: 30)
                              : null,
                        ),
                      ),
                    ),
                  Transform.rotate(
                    angle: _angle,
                    child: Image.asset(
                      'assets/bottle.jpeg', // Default bottle image
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _spinBottle,
              child: Text('Spin the Bottle'),
            ),
          ],
        ),
      ),
=======
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
>>>>>>> 1a312d654217a5b714ecfe9b3a113e7fee436e98
    );
  }
}
