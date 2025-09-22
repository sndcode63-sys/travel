import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleWidth;
  static late double scaleHeight;
  static late double textScaleFactor;

  // Base design size (Figma/XD)
  static const double baseWidth = 390;
  static const double baseHeight = 780;

  // Context ke bina initialize
  static void init() {
    final window = WidgetsBinding.instance.window;
    screenWidth = window.physicalSize.width / window.devicePixelRatio;
    screenHeight = window.physicalSize.height / window.devicePixelRatio;

    // Scale factors
    scaleWidth = screenWidth / baseWidth;
    scaleHeight = screenHeight / baseHeight;

    // Text scale factor (screen ke width ke hisab se)
    textScaleFactor = scaleWidth;
  }

  // Orientation aware width
  static double w(double width) => width * scaleWidth;
  static double h(double height) => height * scaleHeight;
  static double sp(double fontSize) => fontSize * textScaleFactor;
  static double r(double radius) => radius * scaleWidth;
  static EdgeInsets px(double val) => EdgeInsets.symmetric(horizontal: w(val));
  static EdgeInsets py(double val) => EdgeInsets.symmetric(vertical: h(val));
  static EdgeInsets pAll(double val) => EdgeInsets.all(w(val));
}



extension SizeExtensions on num {
  double get w => SizeConfig.w(toDouble());
  double get h => SizeConfig.h(toDouble());
  double get sp => SizeConfig.sp(toDouble());
  double get r => SizeConfig.r(toDouble());

  // Common paddings
  EdgeInsets get pAll => EdgeInsets.all(SizeConfig.w(toDouble()));
  EdgeInsets get px => EdgeInsets.symmetric(horizontal: SizeConfig.w(toDouble()));
  EdgeInsets get py => EdgeInsets.symmetric(vertical: SizeConfig.h(toDouble()));

  // Specific paddings
  EdgeInsets get pt => EdgeInsets.only(top: SizeConfig.h(toDouble()));
  EdgeInsets get pb => EdgeInsets.only(bottom: SizeConfig.h(toDouble()));
  EdgeInsets get pl => EdgeInsets.only(left: SizeConfig.w(toDouble()));
  EdgeInsets get pr => EdgeInsets.only(right: SizeConfig.w(toDouble()));
}
