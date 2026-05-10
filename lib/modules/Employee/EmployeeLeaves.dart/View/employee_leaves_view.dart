import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/controller/employee_leaves_controller.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveBalanceWidget.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveCard.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class EmployeeLeavesView extends GetView<EmployeeLeavesController> {
  const EmployeeLeavesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'الإجازات',
        actions: [
          if (controller.ismanger)
            Padding(
              padding: EdgeInsets.only(right: 10.spAdaptive(context)),
              child: Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.mangerResponse);
                      },
                      icon: Icon(
                        Icons.record_voice_over_outlined,
                        size: 17.spAdaptive(context),
                      ),
                    ),

                    /// Badge
                    if (controller.reponseCounter.value > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: EdgeInsets.symmetric(
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
                            controller.reponseCounter > 99
                                ? "99+"
                                : controller.reponseCounter.toString(),
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
              await controller.fetchAllData();
              await Get.find<Homepagecontroller>().loadall();
            },
          );
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1360
                  : isTablet
                  ? 980
                  : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                isDesktop ? 24.spAdaptive(context) : 12.spAdaptive(context),
              ),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.leaveBalances.value != null)
                          Expanded(
                            flex: 3,
                            child: LeaveBalanceCard(
                              balance: controller.leaveBalances.value!,
                              appointmentDate: controller.appoimentdate,
                            ),
                          ),
                        if (controller.leaveBalances.value != null)
                          SizedBox(width: 24),
                        Expanded(flex: 5, child: _buildLeavesContent(context)),
                      ],
                    )
                  : Column(
                      children: [
                        if (controller.leaveBalances.value != null)
                          LeaveBalanceCard(
                            balance: controller.leaveBalances.value!,
                            appointmentDate: controller.appoimentdate,
                          ),
                        if (controller.leaveBalances.value != null)
                          Gap(10.spAdaptive(context)),
                        Expanded(child: _buildLeavesContent(context)),
                      ],
                    ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLeavesContent(BuildContext context) {
    if (controller.myLeaves.isEmpty) {
      return Center(
        child: Text(
          'لا توجد إجازات مسجلة',
          style: cairoStyle(fontSize: 15.spAdaptive(context)),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.fetchMyLeaves,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.spAdaptive(context)),
        itemCount: controller.myLeaves.length,
        itemBuilder: (context, index) {
          final leave = controller.myLeaves[index];
          return Leavecard(leave: leave);
        },
      ),
    );
  }
}
