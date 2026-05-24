import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'سجل الأذونات',
        actions: [
          if (controller.ismanager)
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.permissionReequest);
                      },
                      icon: Icon(
                        Icons.voice_chat,
                        size: 20.spAdaptive(context),
                      ),
                    ),

                    /// Badge
                    if (controller.padgeCount > 0)
                      Positioned(
                        right: isDesktop ? 40 : 25,
                        top: isDesktop ? 25 : 20,
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
                              fontSize: 9.spAdaptive(context),
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
          return const NoPermissionWidget();
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1100
                  : isTablet
                  ? 900
                  : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 24 : 12),
              child: const ListPermissionCards(),
            ),
          ),
        );
      }),
    );
  }
}
