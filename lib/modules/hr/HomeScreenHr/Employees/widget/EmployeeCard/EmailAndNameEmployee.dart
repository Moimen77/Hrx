import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeModel.dart';

class Emailandnameemployee extends StatelessWidget {
  const Emailandnameemployee({super.key, required this.employee});
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name ?? 'no name',
            style: cairoStyle(
              fontSize: 18,
              fontweight: FontWeight.bold,
              fontcolor: Appcolors.primarycolor,
            ),
          ),
          Text(
            employee.email ?? 'no email', // افترضت وجود حقل email
            style: cairoStyle(fontSize: 14, fontcolor: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
