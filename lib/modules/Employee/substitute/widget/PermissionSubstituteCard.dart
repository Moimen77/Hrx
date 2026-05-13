import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';

class PermissionSubstituteCard extends GetView<SubstituteController> {
  final PerrmissionModel permission;
  const PermissionSubstituteCard({super.key, required this.permission});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.spAdaptive(context)),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.spAdaptive(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10.spAdaptive(context),
              runSpacing: 10.spAdaptive(context),
              children: [
                CircleAvatar(
                  radius: 20.spAdaptive(context),
                  backgroundColor: Color(0xffe0f2fe),
                  child: Icon(
                    Icons.person,
                    color: Color(0xff0284c7),
                    size: 20.spAdaptive(context),
                  ),
                ),
                SizedBox(
                  width: 320.spAdaptive(context).clamp(180, 420).toDouble(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        permission.employeeName!,
                        style: cairoStyle(
                          fontweight: FontWeight.bold,
                          fontSize: 15.spAdaptive(context),
                        ),
                      ),
                      Text(
                        'طلب بديل لـ ${permission.perm_type}',
                        style: cairoStyle(
                          fontcolor: Colors.grey[600],
                          fontSize: 13.spAdaptive(context),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.isMe(permission.substituteEmployeeId))
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.spAdaptive(context),
                      vertical: 4.spAdaptive(context),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(8.spAdaptive(context)),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      'أنت البديل',
                      style: cairoStyle(
                        fontSize: 12.spAdaptive(context),
                        fontcolor: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            Divider(height: 20.spAdaptive(context)),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18.spAdaptive(context),
                  color: Colors.grey,
                ),
                SizedBox(width: 8.spAdaptive(context)),
                Text(
                  TimeHelper.formatDateToArabic(permission.perm_date),
                  style: cairoStyle(fontSize: 14.spAdaptive(context)),
                ),
              ],
            ),
            if (!(controller.isMe(permission.substituteEmployeeId)) &&
                permission.substituteEmployeeId == null) ...[
              SizedBox(height: 16.spAdaptive(context)),
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
                    padding: EdgeInsets.symmetric(
                      vertical: 12.spAdaptive(context),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.spAdaptive(context)),
                    ),
                  ),
                  child: Text(
                    'موافقة كبديل',
                    style: cairoStyle(
                      fontcolor: Colors.white,
                      fontweight: FontWeight.bold,
                      fontSize: 14.spAdaptive(context),
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
