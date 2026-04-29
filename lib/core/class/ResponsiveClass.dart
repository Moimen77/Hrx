import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double shortestSide(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  static bool isMobile(BuildContext context) => shortestSide(context) < 600;

  static bool isTablet(BuildContext context) =>
      shortestSide(context) >= 600 &&
      shortestSide(context) < 1024 &&
      width(context) < 1024;

  static bool isDesktop(BuildContext context) => width(context) >= 1024;
}
