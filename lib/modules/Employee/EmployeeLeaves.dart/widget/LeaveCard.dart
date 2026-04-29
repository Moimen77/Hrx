import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as dart_ui;
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/controller/employee_leaves_controller.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveBadge.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveData.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class Leavecard extends GetView<EmployeeLeavesController> {
  const Leavecard({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: dart_ui.TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Filtercard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(10),
                  Leavedata(leave: leave),
                  const Gap(10),
                  LeaveStatusBadge(status: leave.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
