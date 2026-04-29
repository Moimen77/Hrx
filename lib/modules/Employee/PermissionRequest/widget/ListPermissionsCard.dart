import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
          padding: const EdgeInsets.all(16),
          itemCount: controller.permissionsList.length,
          separatorBuilder: (context, index) => const Gap(10),
          itemBuilder: (context, index) {
            final permission = controller.permissionsList[index];
            return PerrmissionCard(permission: permission);
          },
        ),
      ),
    );
  }
}
