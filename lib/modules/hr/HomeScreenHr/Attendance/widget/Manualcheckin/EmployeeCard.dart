import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/statusBadgeEmployees.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/whiteCard.dart';

class Employeecard extends StatelessWidget {
  const Employeecard({super.key, required this.emp});
  final EmployeeModel emp;

  @override
  Widget build(BuildContext context) {
    return Whitecard(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38.spAdaptive(context),
            backgroundImage: emp.imageUrl == null
                ? null
                : NetworkImage(emp.imageUrl!),
            child: emp.imageUrl == null
                ? Icon(
                    Icons.person,
                    size: 40.spAdaptive(context),
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(height: 12),

          Text(
            emp.name ?? '',
            style: cairoStyle(fontSize: 17.spAdaptive(context)),
          ),
          const SizedBox(height: 4),
          Text(
            emp.departmentName!,
            style: cairoStyle(fontSize: 14.spAdaptive(context)),
          ),

          const SizedBox(height: 12),

          Statusbadgeemployees(status: emp.status ?? 'Active'),
        ],
      ),
    );
  }
}
