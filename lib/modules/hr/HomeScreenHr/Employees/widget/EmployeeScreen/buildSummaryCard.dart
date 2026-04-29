import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Buildsummarycard extends StatelessWidget {
  const Buildsummarycard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });
  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Appcolors.primarycolor, size: 28),
          const Gap(8),
          Text(
            value,
            style: cairoStyle(
              fontSize: 20,
              fontweight: FontWeight.bold,
              fontcolor: Colors.black87,
            ),
          ),
          Text(
            title,
            style: cairoStyle(fontSize: 14, fontcolor: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
