import 'package:bmi_cal/constant_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IconText.dart';
import 'ContainerFile.dart';

enum Gender { male, female }
int sliderHeigth=180;
int sliderWeigth=60;
class InputPage extends StatefulWidget {
  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
//   Color maleColor=deActiveColor;
//   Color femaleColor=deActiveColor;
//
//   void updateColor(Gender gendertype){
// if(gendertype==Gender.male){
//   maleColor=activeColor;
//   femaleColor=deActiveColor;
// }
// if(gendertype==Gender.female
// ){
//   maleColor=activeColor;
//   femaleColor=deActiveColor;
// }
//   }
  Gender? selectGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ), // AppBar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RepeatRefactorCode(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.male;
                      });
                    },
                    colors: selectGender == Gender.male
                        ? activeColor
                        : deActiveColor,
                    cardwidget: RefactorTextandIcon(
                      iconData: FontAwesomeIcons.person,
                      label: "MALE",
                    ),
                  ),
                ),
                Expanded(
                    child: RepeatRefactorCode(
                  colors: selectGender == Gender.female
                      ? activeColor
                      : deActiveColor,
                  onPressed: () {
                    setState(() {
                      selectGender = Gender.male;
                    });
                  },
                  cardwidget: RefactorTextandIcon(
                    iconData: FontAwesomeIcons.female,
                    label: "Female",
                  ),
                )),
              ],
            ),
          ),
          Expanded(
            child: RepeatRefactorCode(
              colors: Color(0xFF1D1E33),
              cardwidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGTH',
                    style: kLabelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sliderHeigth.toString(),
                        style: KNumerStye,
                      ),
                      Text(
                        'cm',
                        style: kLabelStyle,
                      ),

                    ],
                  ),
                  Slider(
                    value: sliderHeigth.toDouble(),
                    min: 120.0,
                    max:220.0,
                    activeColor: Color(0xFFEB1555),
                    inactiveColor:Color(0xFF8D8E98),
                    onChanged:(double newValue){
                      setState(() {
                        sliderHeigth=newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RepeatRefactorCode(
                    colors: Color(0xFF1D1E33),
                    cardwidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WEIGTH',style:kLabelStyle
                          ,),
                        Text(sliderWeigth.toString(),style: KNumerStye
                          ,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                        )

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RepeatRefactorCode(
                    colors: Color(0xFF1D1E33),
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

