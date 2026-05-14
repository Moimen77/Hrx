import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class AllEmployeesSelected extends StatelessWidget {
  const AllEmployeesSelected({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.spAdaptive(context)),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(
          "تم اختيار جميع الموظفين",
          style: cairoStyle(
            fontSize: 15.spAdaptive(context),
            fontcolor: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
