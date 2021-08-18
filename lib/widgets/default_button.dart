import 'package:flutter/material.dart';
import '../configs/colors.dart';
import '../configs/screen_configs.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getSizeOfScreenHeight(50),
      child: TextButton(
        style: TextButton.styleFrom(
           backgroundColor: Colors.white,
           shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
         
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontSize: getSizeOfScreenWidth(42),
                color: kBrightColor,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
