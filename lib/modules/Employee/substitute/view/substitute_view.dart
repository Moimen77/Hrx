import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/substitute/controller/Substitute_Controller.dart';
import 'package:hrx/modules/Employee/substitute/widget/LeaveCard.dart';
import 'package:hrx/modules/Employee/substitute/widget/PermissionSubstituteCard.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class SubstituteView extends GetView<SubstituteController> {
  const SubstituteView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'طلبات بديل'),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1160
                  : isTablet
                  ? 920
                  : double.infinity,
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: Appcolors.primarycolor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Appcolors.primarycolor,
                    indicatorWeight: 3,
                    labelStyle: cairoStyle(
                      fontweight: FontWeight.bold,
                      fontSize: 14.spAdaptive(context),
                    ),
                    tabs: const [
                      Tab(text: 'الإجازات'),
                      Tab(text: 'الأذونات'),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (!controller.networkController.isConnected.value) {
                      return NoInternetWidget(
                        onPressed: () async {
                          await controller.fetchSubstituteLeaves();
                          await controller.fetchSubstitutePermissions();
                        },
                      );
                    }
                    return TabBarView(
                      children: [
                        Obx(() {
                          if (controller.isLoading.value &&
                              controller.substituteLeaves.isEmpty) {
                            return Loadingcircular();
                          }
                          if (controller.substituteLeaves.isEmpty) {
                            return Center(
                              child: Text(
                                'لا توجد طلبات بديل للإجازات.',
                                style: cairoStyle(
                                  fontSize: 16.spAdaptive(context),
                                ),
                              ),
                            );
                          }
                          return RefreshIndicator(
                            onRefresh: controller.fetchSubstituteLeaves,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListView.builder(
                                padding: EdgeInsets.fromLTRB(
                                  12.spAdaptive(context),
                                  0,
                                  12.spAdaptive(context),
                                  16.spAdaptive(context),
                                ),
                                itemCount: controller.substituteLeaves.length,
                                itemBuilder: (context, index) {
                                  final leave =
                                      controller.substituteLeaves[index];
                                  return LeaveCard(leave: leave);
                                },
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller.isLoading.value &&
                              controller.substitutePermissions.isEmpty) {
                            return Loadingcircular();
                          }
                          if (controller.substitutePermissions.isEmpty) {
                            return Center(
                              child: Text(
                                'لا توجد طلبات بديل للأذونات.',
                                style: cairoStyle(
                                  fontSize: 16.spAdaptive(context),
                                ),
                              ),
                            );
                          }
                          return RefreshIndicator(
                            onRefresh: controller.fetchSubstitutePermissions,
                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(
                                12.spAdaptive(context),
                                0,
                                12.spAdaptive(context),
                                16.spAdaptive(context),
                              ),
                              itemCount:
                                  controller.substitutePermissions.length,
                              itemBuilder: (context, index) {
                                final permission =
                                    controller.substitutePermissions[index];
                                return PermissionSubstituteCard(
                                  permission: permission,
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
