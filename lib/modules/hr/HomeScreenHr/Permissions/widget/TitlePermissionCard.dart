import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/controller/PermissionController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/StatusPermissionBadge.dart';

class TitlePermissionCard extends GetView<PermissionController> {
  const TitlePermissionCard({super.key, required this.permission});
  final PerrmissionModel permission;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15.spAdaptive(context),
                  child: Icon(
                    Icons.access_alarms,
                    size: 20.spAdaptive(context),
                  ),
                ),
                SizedBox(width: 5.spAdaptive(context)),
                Expanded(
                  child: Text(
                    permission.perm_type,
                    style: cairoStyle(
                      fontSize: 15.spAdaptive(context),
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isCompact ? 10 : 0),
            Align(
              alignment: Alignment.centerRight,
              child: StatusPermissionBadge(status: permission.hr_approve),
            ),
          ],
        );
      },
    );
  }
}
