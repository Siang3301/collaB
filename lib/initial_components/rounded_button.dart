import 'package:flutter/material.dart';
import 'package:collab/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,

    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor, fontFamily: 'Raleway', fontWeight: FontWeight.bold ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }
}
