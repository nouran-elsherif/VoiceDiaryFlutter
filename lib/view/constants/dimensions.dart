import 'package:flutter/widgets.dart';

class AppDimensions {
  static double width;
  static double height;
  AppDimensions(context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
  static double convertToH(double value) {
    return (value / 812) * height;
  }

  static double convertToW(double value) {
    return (value / 375) * width;
  }

  static double getFullHeight() {
    return height;
  }

  static double getFullWidth() {
    return width;
  }
}
