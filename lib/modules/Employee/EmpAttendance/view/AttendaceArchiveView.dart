// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/AttendanceCard.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/FilterSection.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class Attendacearchiveview extends GetView<AttendanceArciveController> {
  const Attendacearchiveview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'سجل الحضور'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.loadAttendance(controller.employeeId);
                await Get.find<Homepagecontroller>().loadall();
              },
            );
          }
          return Column(
            children: [
              FilterSection(),
              Expanded(
                child: controller.isLoading.value
                    ? Loadingcircular()
                    : controller.records.isEmpty
                    ? Center(
                        child: Text('لا توجد سجلات حضور', style: cairoStyle()),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: controller.records.length,
                        itemBuilder: (context, index) {
                          final item = controller.records[index];
                          return AttendanceCardArcive(item: item);
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
