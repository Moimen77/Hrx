import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';

class Statusbadgeemployees extends StatelessWidget {
  const Statusbadgeemployees({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (status == "Active") {
      color = Colors.green;
    } else if (status == "اجازة") {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.spAdaptive(context),
        ),
      ),
    );
  }
}
