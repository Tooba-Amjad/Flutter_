import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ), // AppBar
      body: Center(
        child: Text('Body Text'),
      ), // Center
    ); // Scaffold
  }
}