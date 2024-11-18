import 'package:bmi_cal/ContainerFile.dart';
import 'package:bmi_cal/constant_file.dart';
import 'package:bmi_cal/input_page.dart';
import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  ResultScreen({required this.interperatation
    ,required this.bmiResult,required this.resultText});
  final String bmiResult;
  final String resultText;
  final String interperatation;




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
                Text(resultText,style: kResultText),
                Text(bmiResult,style: kBMITextStyle),
                Text(interperatation,

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
