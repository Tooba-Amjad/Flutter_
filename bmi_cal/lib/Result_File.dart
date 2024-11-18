import 'package:bmi_cal/ContainerFile.dart';
import 'package:bmi_cal/constant_file.dart';
import 'package:bmi_cal/input_page.dart';
import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('BMI Result'),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(

            child:Center(
            child: Text('Your Result',style: kTitleStyle,),
          ))
    ),
          Expanded(
            flex: 5,
            child:RepeatRefactorCode(colors: activeColor,
            cardwidget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Normal',style: kResultText),
                Text('18.3',style: kBMITextStyle),
                Text('BMI is low you should have to work more',

                    textAlign:TextAlign.center,
                    style: kBodyTextStyle),

              ],
            ),),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InputPage()));
              },
              child: Container(
                  color: Color(0xFFEB15555),
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 80.0,
                  child: Center(
                    child: Text(
                      "ReCalculate",
                      style: kLargebutton,
                    ),

                  )))
        ],
      )
     ,
    );
  }
}
