import 'package:flutter/material.dart';

class ApproveButton extends StatelessWidget {
   ApproveButton({
    Key key,
    @required this.btnBgColor,
    @required this.onClick,
    @required this.btnText,
  }) : super(key: key);

  final  btnBgColor;
  final  onClick;
  final  btnText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Expanded(
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: btnBgColor,
            ),
            onPressed: onClick,
            child: Text(
              btnText,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}