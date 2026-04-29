// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class buildInfoRow extends StatelessWidget {
  const buildInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const Gap(8),
        Text(
          "$label :  ",
          textDirection: TextDirection.rtl,
          style: cairoStyle(
            fontcolor: Colors.grey.shade700,
            fontweight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: cairoStyle(
            fontcolor: Colors.black87,
            fontweight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
