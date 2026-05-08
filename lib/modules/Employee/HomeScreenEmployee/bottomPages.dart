// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Bottompages extends StatelessWidget {
  const Bottompages({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isactive,
  });
  final void Function() onTap;
  final String title;
  final IconData icon;
  final isactive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isactive ? 26.spAdaptive(context) : 23.spAdaptive(context),
            color: isactive ? Appcolors.primarycolor : Colors.grey.shade700,
          ),
          Text(
            title,
            style: cairoStyle(
              fontcolor: isactive
                  ? Appcolors.primarycolor
                  : Colors.grey.shade700,
              fontweight: isactive ? FontWeight.bold : FontWeight.w600,
              fontSize: 14.spAdaptive(context),
            ),
          ),
        ],
      ),
    );
  }
}
