import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/AttendanceFilters.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/AttendanceQuickActions.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/GroupCardItems.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/buildAttendanceCard.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class AttendanceScreen extends GetView<AttendanceController> {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      if (controller.haserror.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchAttendance();
          },
        );
      }
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (isDesktop) {
        return _webLayout(context);
      } else if (isTablet) {
        return _tabletLayout(context);
      } else {
        return _mobileLayout();
      }
    });
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildContent(),
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: _buildContent(spacing: 18),
        ),
      ),
    );
  }

  Widget _webLayout(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Groupcarditems(),
                    SizedBox(height: 20),
                    Attendancefilters(),
                    SizedBox(height: 20),
                    Buildattendancecard(),
                  ],
                ),
              ),

              Expanded(flex: 3, child: AttendanceQuickActions()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent({double spacing = 15}) {
    return Column(
      children: [
        const Groupcarditems(),
        SizedBox(height: spacing),
        const Attendancefilters(),
        SizedBox(height: spacing),
        const Buildattendancecard(),
        SizedBox(height: spacing + 7),
        const AttendanceQuickActions(),
      ],
    );
  }
}
