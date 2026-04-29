import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';

class PermissionSubstituteCard extends GetView<SubstituteController> {
  final PerrmissionModel permission;
  const PermissionSubstituteCard({super.key, required this.permission});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xffe0f2fe),
                  child: Icon(Icons.person, color: Color(0xff0284c7)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        permission.employeeName!,
                        style: cairoStyle(
                          fontweight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'طلب بديل لـ ${permission.perm_type}',
                        style: cairoStyle(
                          fontcolor: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.isMe(permission.substituteEmployeeId))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      'أنت البديل',
                      style: cairoStyle(fontSize: 12, fontcolor: Colors.green),
                    ),
                  ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  TimeHelper.formatDateToArabic(permission.perm_date),
                  style: cairoStyle(fontSize: 14),
                ),
              ],
            ),
            if (!(controller.isMe(permission.substituteEmployeeId)) &&
                permission.substituteEmployeeId == null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.acceptPermissionSubstitute(
                      permission.id!,
                      permission.employeeName!,
                      permission.employeeId,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primarycolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'موافقة كبديل',
                    style: cairoStyle(
                      fontcolor: Colors.white,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
