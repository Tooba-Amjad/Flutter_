import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class RefactorTextandIcon extends StatelessWidget {
  RefactorTextandIcon({required this.iconData,required this.label});
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(label,style: TextStyle(

          fontSize: 18.0
        ))
      ]

    );
  }
}

class RepeatRefactorCode extends StatelessWidget {
 final Color colors;
 final Widget? cardwidget;
  RepeatRefactorCode({
    required this.colors,
     this.cardwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardwidget,
    );
  }
}
