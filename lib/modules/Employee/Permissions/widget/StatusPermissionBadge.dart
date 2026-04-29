// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class StatusPermissionBadge extends StatelessWidget {
  StatusPermissionBadge({super.key, this.status});
  final bool? status;
  String text = '';
  Color color = Colors.green;
  IconData icon = Icons.check_circle_outline;

  @override
  Widget build(BuildContext context) {
    if (status == true) {
      text = 'مقبول';
      color = Colors.green;
      icon = Icons.check_circle_outline;
    } else if (status == false) {
      text = 'مرفوض';
      color = Colors.red;
      icon = Icons.cancel_outlined;
    } else {
      text = 'معلق';
      color = Colors.orange;
      icon = Icons.access_time;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: cairoStyle(
              fontSize: 12,
              fontcolor: color,
              fontweight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
