// f:\Flutter\hrx_employees\lib\modules\ManagerLeaves\view\ManagerLeavesView.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/widget/LeaveData.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/Manger_Leave_Response.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/RowApproveAndReject.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ManagerLeavesView extends GetView<ManagerLeavesController> {
  const ManagerLeavesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

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
            child: Text(
              'لا توجد طلبات معلقة',
              style: cairoStyle(fontSize: 16.spAdaptive(context)),
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1040
                  : isTablet
                  ? 900
                  : double.infinity,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchPendingLeaves();
                },
                child: ListView.builder(
                  itemCount: controller.pendingLeaves.length,
                  padding: EdgeInsets.all(
                    isDesktop ? 24.spAdaptive(context) : 16.spAdaptive(context),
                  ),
                  itemBuilder: (context, index) {
                    final leave = controller.pendingLeaves[index];
                    return _ManagerLeaveCard(
                      leave: leave,
                      onApprove: () => controller.updateStatus(leave, 'مقبولة'),
                      onReject: () => controller.updateStatus(leave, 'مرفوضة'),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ManagerLeaveCard extends StatelessWidget {
  const _ManagerLeaveCard({
    required this.leave,
    required this.onApprove,
    required this.onReject,
  });

  final LeaveModel leave;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.spAdaptive(context)),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.spAdaptive(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 18.spAdaptive(context),
                  backgroundColor: const Color(0xffe0f2fe),
                  child: Icon(
                    Icons.person_outline,
                    color: const Color(0xff0284c7),
                    size: 20.spAdaptive(context),
                  ),
                ),
                Text(
                  leave.employeeName ?? 'غير معروف',
                  style: cairoStyle(
                    fontweight: FontWeight.bold,
                    fontSize: 15.spAdaptive(context),
                  ),
                ),
              ],
            ),
            Divider(height: 18.spAdaptive(context)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.spAdaptive(context)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.spAdaptive(context)),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 8.spAdaptive(context),
                runSpacing: 8.spAdaptive(context),
                children: [
                  Icon(
                    Icons.event_note_outlined,
                    color: Colors.grey,
                    size: 20.spAdaptive(context),
                  ),
                  SizedBox(
                    width: 720.spAdaptive(context).clamp(220, 760).toDouble(),
                    child: Leavedata(leave: leave),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.spAdaptive(context)),
            RowApproveAndReject(onApprove: onApprove, onReject: onReject),
          ],
        ),
      ),
    );
  }
}
