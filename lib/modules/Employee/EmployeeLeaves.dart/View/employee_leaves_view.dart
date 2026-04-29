import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الإجازات',
        actions: [
          if (controller.ismanger)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.mangerResponse);
                      },
                      icon: const Icon(Icons.record_voice_over_outlined),
                    ),

                    /// Badge
                    if (controller.reponseCounter.value > 0)
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
                            controller.reponseCounter > 99
                                ? "99+"
                                : controller.reponseCounter.toString(),
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
              await controller.fetchAllData();
              await Get.find<Homepagecontroller>().loadall();
            },
          );
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            controller.leaveBalances.value == null
                ? SizedBox.shrink()
                : LeaveBalanceCard(
                    balance: controller.leaveBalances.value!,
                    appointmentDate: controller.appoimentdate,
                  ),
            Gap(10),
            Expanded(
              child: controller.myLeaves.isEmpty
                  ? Center(
                      child: Text('لا توجد إجازات مسجلة', style: cairoStyle()),
                    )
                  : RefreshIndicator(
                      onRefresh: controller.fetchMyLeaves,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.myLeaves.length,
                        itemBuilder: (context, index) {
                          final leave = controller.myLeaves[index];
                          return Leavecard(leave: leave);
                        },
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
