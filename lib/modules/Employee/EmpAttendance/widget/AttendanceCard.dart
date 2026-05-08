import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
      margin: EdgeInsets.symmetric(
        horizontal: 4.spAdaptive(context),
        vertical: 8.spAdaptive(context),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.spAdaptive(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateAndAtatus(item: item),
            SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey.shade200, thickness: 1),
            SizedBox(height: 16),
            TimeCheckInAndOut(item: item),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 18.spAdaptive(context),
                        color: Colors.blue.shade600,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.shift_name ?? 'غير محدد',
                          style: cairoStyle(
                            fontSize: 13.spAdaptive(context),
                            fontcolor: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18.spAdaptive(context),
                        color: Colors.red.shade600,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.branch_name ?? 'غير محدد',
                          style: cairoStyle(
                            fontSize: 13.spAdaptive(context),
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
