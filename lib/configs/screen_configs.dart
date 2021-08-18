import 'package:flutter/material.dart';

class ScreenConfig {
  static MediaQueryData _mediaQueryData;
  static double screenHeight = 0;
  static double screenWidth = 0;
  static double defaultSize = 0;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}

double getSizeOfScreenHeight(double heightInput) {
  double screenHeight = ScreenConfig.screenHeight;

  return (heightInput / 812.0) * screenHeight;
}

double getSizeOfScreenWidth(double heightInput) {
  double screenWidth = ScreenConfig.screenWidth;

  return (heightInput / 812.0) * screenWidth;
}

const double regularPadding = 12.0;
const double mediumPadding = 16.0;
double textFieldPadding = getSizeOfScreenHeight(18.0);
double screenVerticalPadding = getSizeOfScreenWidth(70);
