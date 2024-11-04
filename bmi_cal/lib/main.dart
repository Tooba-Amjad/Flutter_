import package:flutter/material.dart';
void main() => runApp (BMICalculator());
class BMICalculator extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: InputPage(),
    );
  }
}
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
  class_InputPageState extends State<InputPage> {
  @override