import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Titletext extends StatelessWidget {
  const Titletext({super.key, required this.title, required this.size});
  final String title;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: cairoStyle(fontSize: size, fontweight: FontWeight.bold),
    );
  }
}
