import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/ShowSalaryDetails.dart';

class ShowSalaryDetailsButton extends StatelessWidget {
  const ShowSalaryDetailsButton({super.key, required this.salary});
  final SalaryResultModel salary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2C3E50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => showDetails(context, salary),
        child: Text(
          "عرض التفاصيل",
          style: cairoStyle(fontSize: 12, fontcolor: Colors.white),
        ),
      ),
    );
  }
}
