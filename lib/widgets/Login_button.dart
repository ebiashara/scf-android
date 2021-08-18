import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.text,
    @required this.onClick,
    @required this.bgColor,
    @required this.textColor,
  }) : super(key: key);

  final  text;
  final  onClick;
  final  bgColor;
  final  textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            primary: bgColor),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
