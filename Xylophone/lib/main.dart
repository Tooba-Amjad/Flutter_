import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophoneHome(),
    );
  }
}

class XylophoneHome extends StatefulWidget {
  @override
  _XylophoneHomeState createState() => _XylophoneHomeState();
}

class _XylophoneHomeState extends State<XylophoneHome> {
  final player = AudioPlayer();
  List<bool> isPressed = List.generate(7, (_) => false);

  double volume = 1.0; // Volume level from 0.0 to 1.0

  // Define colors for keys
  List<Color> keyColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];

  // Define corresponding sound numbers
  List<int> soundNumbers = [1, 2, 3, 4, 5, 6, 7];

  // Function to play sound
  Future<void> playSound(int soundNumber) async {
    await player.setVolume(volume);
    await player.play(AssetSource('note$soundNumber.wav'));
  }
  void showVolumeSlider() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Volume Control'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: volume,
                    onChanged: (newVolume) {
                      setState(() {
                        volume = newVolume; // Update volume in the dialog
                      });
                    },
                    onChangeEnd: (newVolume) {
                      player.setVolume(newVolume); // Set volume when slider is released
                    },
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: (volume * 100).round().toString(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


  // Function to show color picker
  void showColorPicker(int index) {
    Color currentColor = keyColors[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color for Key ${index + 1}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                setState(() {
                  keyColors[index] = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
  }

  // Function to show sound picker
  void showSoundPicker(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a sound for Key ${index + 1}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(7, (i) {
              return ListTile(
                title: Text('Sound ${i + 1}'),
                onTap: () {
                  setState(() {
                    soundNumbers[index] = i + 1;
                  });
                  Navigator.of(context).pop();
                },
              );
            }),
          ),
        );
      },
    );
  }

  // Function to build each key
  Widget buildKey({required int index}) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed[index] = true; // Set pressed state to true on touch
          });
          playSound(soundNumbers[index]);
        },
        onTapUp: (_) {
          setState(() {
            isPressed[index] = false; // Reset pressed state on release
          });
        },
        onTapCancel: () {
          setState(() {
            isPressed[index] = false; // Reset pressed state on cancel
          });
        },
        onLongPress: () {
          showColorPicker(index);
        },
        onDoubleTap: () {
          showSoundPicker(index);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: isPressed[index] ? Colors.grey : keyColors[index], // Change color when pressed
          child: Center(
            child: Text(
              'Key ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customized Xylophone'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: showVolumeSlider, // Call the volume slider function
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(7, (index) => buildKey(index: index)),
      ),
    );
  }
}
