import 'package:flutter/material.dart';

class DashboardAction extends StatelessWidget {
  final Color iconColor;
  final Color cardColor;
  final String title;
  final iconSvg;
  var onClick;
   DashboardAction({
    Key key,
    this.cardColor,this.iconColor,this.iconSvg,this.title,this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(100.0),
          color: cardColor,
          child: IconButton(
            padding: EdgeInsets.all(15.0),
            icon: Icon(iconSvg),
            color: iconColor,
            iconSize: 30.0,
            onPressed: onClick,
          ),
        ),
        SizedBox(height: 8.0),
        Text(title,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))
      ],
    );
  }
}