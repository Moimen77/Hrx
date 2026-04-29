import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Infosalaryitem extends StatelessWidget {
  const Infosalaryitem({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: cairoStyle(fontSize: 12, fontcolor: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: cairoStyle(fontSize: 14, fontweight: FontWeight.w600),
        ),
      ],
    );
  }
}
