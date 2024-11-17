import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'IconText.dart';
import 'ContainerFile.dart';

class RepeatRefactorCode extends StatelessWidget {
  final Color colors;
  final Widget? cardwidget;
  final Function? onPressed;
  RepeatRefactorCode(
      {required this.colors, this.cardwidget,  this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

          onTap: () {
            if (onPressed != null) {
              onPressed!(); // Safe Call
            }
          },


        child:Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: cardwidget,
    ));
  }
}
