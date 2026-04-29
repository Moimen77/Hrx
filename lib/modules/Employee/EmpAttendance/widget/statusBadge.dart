// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Statusbadge extends StatelessWidget {
  Statusbadge({super.key, required this.status});
  final String status;
  Color? color;
  String? text;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case "present":
        color = Colors.green;
        text = "حاضر";
        break;
      case "late":
        color = Colors.orange;
        text = "متأخر";
        break;
      case "absent":
        color = Colors.red;
        text = "غائب";
        break;
      default:
        color = Colors.blue;
        text = status;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          text ?? '',
          style: cairoStyle(
            fontcolor: color,
            fontweight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
