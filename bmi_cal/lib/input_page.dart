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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RepeatRefactorCode(colors:Color(0xFF1D1E33),),
                ),
                Expanded(
                  child:RepeatRefactorCode(colors:Color(0xFF1D1E33),),
                ),
              ],
            ),
          ),
          Expanded(
            child:RepeatRefactorCode(colors:Color(0xFF1D1E33),),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child:RepeatRefactorCode(colors:Color(0xFF1D1E33),),
                ),
                Expanded(
                  child: RepeatRefactorCode(colors:Color(0xFF1D1E33),),
                ),
              ],
            ),
          ),
        ],
      ),
    ); // End of Scaffold
  }
}

class RepeatRefactorCode extends StatelessWidget {
 final Color colors;
  RepeatRefactorCode({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
