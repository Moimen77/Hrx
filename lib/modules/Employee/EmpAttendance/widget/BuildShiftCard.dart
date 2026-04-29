import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/ShiftsModel.dart';

class BuildshiftCard extends StatelessWidget {
  final ShiftModel shift;

  const BuildshiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // مهم جد
      children: [
        // خط بسيط على الشمال
        Container(width: 6, height: 35, color: Colors.grey[300]),
        const SizedBox(width: 10),
        // النصوص
        Text(
          shift.name,
          style: cairoStyle(fontSize: 14, fontweight: FontWeight.w600),
        ),
      ],
    );
  }
}
