import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';

class SalaryValueContainer extends StatelessWidget {
  const SalaryValueContainer({super.key, required this.salary});
  final SalaryResultModel salary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "${salary.finalSalary.toStringAsFixed(1)} ج.م",
        style: cairoStyle(
          fontSize: 14,
          fontweight: FontWeight.bold,
          fontcolor: Colors.green,
        ),
      ),
    );
  }
}
