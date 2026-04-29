import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class LeaveStatusBadge extends StatelessWidget {
  final String status; // pending, rejected, accepted

  const LeaveStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'معلقة':
        bgColor = const Color(0xfffef4e6);
        textColor = const Color(0xfff4a932);

        break;
      case 'مرفوضة':
        bgColor = const Color(0xfffdedeb);
        textColor = const Color(0xffc44132);
        break;

      default:
        bgColor = const Color(0xffe9f7ef);
        textColor = const Color(0xff8bc34a);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor,
      ),
      child: Text(
        status,
        style: cairoStyle(
          fontSize: 13,
          fontweight: FontWeight.bold,
          fontcolor: textColor,
        ),
      ),
    );
  }
}
