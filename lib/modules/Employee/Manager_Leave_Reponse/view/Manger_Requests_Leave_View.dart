// f:\Flutter\hrx_employees\lib\modules\ManagerLeaves\view\ManagerLeavesView.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveData.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/Manger_Leave_Response.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/RowApproveAndReject.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ManagerLeavesView extends GetView<ManagerLeavesController> {
  const ManagerLeavesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ' طلبات الإجازات'),
      body: Obx(() {
        if (!controller.networkController.isConnected.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.fetchPendingLeaves();
            },
          );
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pendingLeaves.isEmpty) {
          return Center(
            child: Text('لا توجد طلبات معلقة', style: cairoStyle(fontSize: 16)),
          );
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchPendingLeaves();
            },
            child: ListView.builder(
              itemCount: controller.pendingLeaves.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final leave = controller.pendingLeaves[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ===== Header =====
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xffe0f2fe),
                              child: Icon(
                                Icons.person_outline,
                                color: Color(0xff0284c7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                leave.employeeName ?? 'غير معروف',
                                style: cairoStyle(
                                  fontweight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 1),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.event_note_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Leavedata(leave: leave),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RowApproveAndReject(
                          onApprove: () =>
                              controller.updateStatus(leave, 'مقبولة'),
                          onReject: () =>
                              controller.updateStatus(leave, 'مرفوضة'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
