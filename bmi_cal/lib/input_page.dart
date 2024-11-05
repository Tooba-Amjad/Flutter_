import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IconText.dart';
import 'ContainerFile.dart';
const activeColor=Color(0xFF1D1E33);
const deActiveColor=Color(0xFF111328);
enum Gender{
  male,
  female
}

class InputPage extends StatefulWidget {

  @override
  InputPageState createState() => InputPageState();
}
class InputPageState extends State<InputPage> {
  Color maleColor=deActiveColor;
  Color femaleColor=deActiveColor;

  void updateColor(Gender gendertype){
if(gendertype==Gender.male){
  maleColor=activeColor;
  femaleColor=deActiveColor;
}
if(gendertype==Gender.female
){
  maleColor=activeColor;
  femaleColor=deActiveColor;
}
  }

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
                  child:GestureDetector(
                    onTap: (){
                      setState(() {
                        updateColor(Gender.male);
                      });
                    },
                  child: RepeatRefactorCode(
                    colors:maleColor,
                    cardwidget: RefactorTextandIcon(
                      iconData:FontAwesomeIcons.person,
                      label: "MALE",
                    ),
                  ),),
                ),
                Expanded(
                child:GestureDetector(
                onTap: (){
                setState(() {
                updateColor(Gender.female);
                });
                },
                  child:RepeatRefactorCode(colors:femaleColor,
                   cardwidget: RefactorTextandIcon(
                     iconData:FontAwesomeIcons.female,
                     label: "Female",
                   ),)
                ),
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




