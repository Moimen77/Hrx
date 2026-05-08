// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

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
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? 1300
                    : isTablet
                    ? 980
                    : double.infinity,
              ),
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 20 : 12),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: FilterSection()),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 2,
                            child: _buildArchiveContent(context),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const FilterSection(),
                          const SizedBox(height: 12),
                          Expanded(child: _buildArchiveContent(context)),
                        ],
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildArchiveContent(BuildContext context) {
    if (controller.isLoading.value) {
      return Loadingcircular();
    }

    if (controller.records.isEmpty) {
      return Center(
        child: Text(
          'لا توجد سجلات حضور',
          style: cairoStyle(fontSize: 15.spAdaptive(context)),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.records.length,
      itemBuilder: (context, index) {
        final item = controller.records[index];
        return AttendanceCardArcive(item: item);
      },
    );
  }
}
