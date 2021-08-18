import 'package:flutter/material.dart';

class SuccessBtn extends StatelessWidget {
  var btnText = "";
  var onPressed;
  var color;

  SuccessBtn({this.btnText, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color)
        ),
        onPressed: onPressed,
        child: Text(btnText),
      ),
    );
  }
}