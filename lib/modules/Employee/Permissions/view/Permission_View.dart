import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/Employee/Permissions/widget/ListPermissionCards.dart';
import 'package:hrx/modules/Employee/Permissions/widget/NoPermissionWidget.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class PermissionView extends GetView<PermissionController> {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'سجل الأذونات',
        actions: [
          if (controller.ismanager)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.permissionReequest);
                      },
                      icon: const Icon(Icons.voice_chat),
                    ),

                    /// Badge
                    if (controller.padgeCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 1.2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            controller.padgeCount > 99
                                ? "99+"
                                : controller.padgeCount.toString(),
                            style: cairoStyle(
                              fontcolor: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: Obx(() {
        if (!controller.networkController.isConnected.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.fetchPermissions();
              await Get.find<Homepagecontroller>().loadall();
            },
          );
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.permissions.isEmpty) {
          return NoPermissionWidget();
        }

        return ListPermissionCards();
      }),
    );
  }
}
