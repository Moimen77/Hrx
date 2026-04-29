import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class Employeestatusrow extends StatelessWidget {
  const Employeestatusrow({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle_outline, color: Colors.grey.shade600, size: 20),
        const Gap(8),
        Text(
          "الحالة: ",
          style: cairoStyle(
            fontcolor: Colors.grey.shade700,
            fontweight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color:
                status ==
                    'Active' // افترضت وجود حقل status
                ? Colors.green.shade100
                : Colors.red.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status == 'Active' ? 'نشط' : 'غير نشط',
            style: cairoStyle(
              fontcolor: status == 'active'
                  ? Colors.green.shade800
                  : Colors.red.shade800,
              fontweight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
