import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/PermissionRequest/controller/ManagerPermissionController.dart';
import 'package:hrx/modules/Employee/PermissionRequest/widget/PerrmissionCard.dart';

class ListPermissionsCard extends GetView<ManagerPermissionController> {
  const ListPermissionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchPermissions(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: controller.permissionsList.length,
          separatorBuilder: (context, index) => Gap(10.spAdaptive(context)),
          itemBuilder: (context, index) {
            final permission = controller.permissionsList[index];
            return PerrmissionCard(permission: permission);
          },
        ),
      ),
    );
  }
}
