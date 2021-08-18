import 'package:flutter/material.dart';
import '../widgets/UpcomingCard.dart';

class DashCards extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  const DashCards({
    Key key,
    this.color,this.title,this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpcomingCard(
      title: title,
      value: value,
      color: color
    );
  }
}
