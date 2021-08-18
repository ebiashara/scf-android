import 'package:flutter/material.dart';
import 'customer_shape_clipper.dart';

class ClipPathWidget extends StatelessWidget {
  const ClipPathWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffF45C2C),
              // Color(0x99F45C2C),
              Color(0xccF45C2C),
              // Color(0xffF45C2C),
            ],
          ),
        ),
      ),
    );
  }
}