import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class BuildDetailsRow extends StatelessWidget {
  const BuildDetailsRow({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
    this.isNegative = false,
    this.valueColor,
  });
  final String title;
  final String value;
  final String? subValue;
  final bool isNegative;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: cairoStyle(
              fontSize: 14.spAdaptive(context),
              fontweight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: cairoStyle(
                fontSize: 14.spAdaptive(context),
                fontweight: FontWeight.bold,
                fontcolor:
                    valueColor ?? (isNegative ? Colors.red : Colors.black),
              ),
            ),
            if (subValue != null)
              Text(
                subValue!,
                style: cairoStyle(
                  fontSize: 10.spAdaptive(context),
                  fontcolor: Colors.grey,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
