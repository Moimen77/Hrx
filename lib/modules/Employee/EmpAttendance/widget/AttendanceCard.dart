import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/DateAndStatus.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/TimeCheckInAndOut.dart';

class AttendanceCardArcive extends StatelessWidget {
  const AttendanceCardArcive({super.key, required this.item});
  final EmployeeDayModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Date and Status
            DateAndAtatus(item: item),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey.shade200, thickness: 1),

            // Time Section
            const SizedBox(height: 16),
            TimeCheckInAndOut(item: item),

            // Footer: Shift and Branch with Icons
            const SizedBox(height: 18),
            Row(
              children: [
                // Shift
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 18,
                        color: Colors.blue.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.shift_name ?? 'غير محدد',
                          style: cairoStyle(
                            fontSize: 13,
                            fontcolor: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Branch
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.branch_name ?? 'غير محدد',
                          style: cairoStyle(
                            fontSize: 13,
                            fontcolor: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
