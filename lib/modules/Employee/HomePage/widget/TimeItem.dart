import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: cairoStyle(
            fontcolor: const Color(0xff939eae),
            fontSize: 14.spAdaptive(context),
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: cairoStyle(
            fontSize: 16.spAdaptive(context),
            fontweight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
