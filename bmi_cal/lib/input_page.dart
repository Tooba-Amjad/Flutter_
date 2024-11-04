import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IconText.dart';
import 'ContainerFile.dart';
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
                  child: RepeatRefactorCode(
                    colors:Color(0xFF1D1E33),
                    cardwidget: RefactorTextandIcon(
                      iconData:FontAwesomeIcons.person,
                      label: "MALA",
                    ),
                  ),
                ),
                Expanded(
                  child:RepeatRefactorCode(colors:Color(0xFF1D1E33),
                   cardwidget: RefactorTextandIcon(
                     iconData:FontAwesomeIcons.female,
                     label: "Female",
                   ),)

                ),
              ],
            ),
          ),
          Expanded(
            child:RepeatRefactorCode(colors:Color(0xFF1D1E33),
                ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child:RepeatRefactorCode(colors:Color(0xFF1D1E33),
                    ),
                ),
                Expanded(
                  child: RepeatRefactorCode(colors:Color(0xFF1D1E33),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    ); // End of Scaffold
  }
}




