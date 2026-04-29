// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmployeeStatusRow.dart';
import 'package:hrx/shared_widgets/InfoRow.dart';

class Employeeinformation extends StatelessWidget {
  const Employeeinformation({super.key, required this.employee});
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInfoRow(
          icon: Icons.phone_android,
          label: "الرقم",
          value: employee.phone ?? '---',
        ),
        const Gap(8),
        buildInfoRow(
          icon: Icons.monetization_on_outlined,
          label: "الراتب الأساسي",
          value:
              "EGP ${((employee.otherSalary ?? 0) + (employee.jobGrade ?? 0) + (employee.experienceSalary ?? 0) + (employee.totalRaises ?? 0)).toStringAsFixed(2)}",
        ),
        const Gap(8),
        buildInfoRow(
          icon: Icons.date_range,
          label: "تاريخ التعيين",
          value: employee.appointmentDate!.toLocal().toString().split(' ')[0],
        ),
        const Gap(8),
        buildInfoRow(
          icon: Icons.work_outline,
          label: "القسم",
          value: employee.departmentName!,
        ),

        const Gap(8),
        Employeestatusrow(status: employee.status ?? 'Active'),
      ],
    );
  }
}
