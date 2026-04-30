import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Infosalaryitem extends StatelessWidget {
  const Infosalaryitem({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: cairoStyle(
            fontSize: 12.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: cairoStyle(
            fontSize: 14.spAdaptive(context),
            fontweight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
