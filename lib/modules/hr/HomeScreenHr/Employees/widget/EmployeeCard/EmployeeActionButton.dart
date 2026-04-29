import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class EmployeeActionButton extends StatelessWidget {
  const EmployeeActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          children: [
            Icon(icon, color: Appcolors.primarycolor, size: 20),
            const Gap(4),
            Text(label, style: cairoStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
