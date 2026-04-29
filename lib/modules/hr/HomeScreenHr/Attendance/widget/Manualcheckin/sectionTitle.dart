import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Sectiontitle extends StatelessWidget {
  const Sectiontitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: cairoStyle(
          fontSize: 15,
          fontweight: FontWeight.bold,
          fontcolor: Colors.grey.shade700,
        ),
      ),
    );
  }
}
