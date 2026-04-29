import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/GroupFilterDate.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/GroupFiltersStatus.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeavesListDisplay.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeavesTextFieldSearch.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class LeaveScreen extends GetView<LeaveController> {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      if (controller.haserror.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchLeaves();
          },
        );
      }

      if (isDesktop) {
        return _desktopLayout();
      } else if (isTablet) {
        return _tabletLayout();
      } else {
        return _mobileLayout();
      }
    });
  }

  Widget _mobileLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: const [
          Leavestextfieldsearch(),
          Gap(12),
          Groupfiltersstatus(),
          Gap(15),
          GroupFilterDate(),
          Gap(15),
          Expanded(child: LeavesListDisplay()),
        ],
      ),
    );
  }

  Widget _tabletLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 980.w),
          child: Column(
            children: const [
              Leavestextfieldsearch(),
              Gap(14),
              Groupfiltersstatus(),
              Gap(16),
              GroupFilterDate(),
              Gap(16),
              Expanded(child: LeavesListDisplay()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Leavestextfieldsearch(),
                        Gap(16),
                        Groupfiltersstatus(),
                        Gap(16),
                        GroupFilterDate(),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                const Expanded(flex: 7, child: LeavesListDisplay()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
