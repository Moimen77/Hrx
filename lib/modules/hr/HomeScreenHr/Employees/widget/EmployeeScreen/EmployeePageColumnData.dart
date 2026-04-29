import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/DepartmentFilterDropDown.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/EmployeeList.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/EmployeeTextSearch.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/PannerSummary.dart';

class Employeepagecolumndata extends StatelessWidget {
  const Employeepagecolumndata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Summary Banner
        Pannersummary(),
        // Search and Filter Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Search Field
              Employeetextsearch(),
              const Gap(10),
              Departmentfilterdropdown(),
              // Department Filter
            ],
          ),
        ),
        // Employee List
        Employeelist(),
      ],
    );
  }
}
