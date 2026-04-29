import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Sectionlabel extends StatelessWidget {
  const Sectionlabel({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Text(
        title,
        style: cairoStyle(
          fontSize: 15,
          fontweight: FontWeight.bold,
          fontcolor: Colors.black87,
        ),
      ),
    );
  }
}
