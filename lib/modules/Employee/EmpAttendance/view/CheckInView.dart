import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/attendanceController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/repo/AttendanceRepo.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/Attendance_services.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/BuildShiftCard.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

import '../../../hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class AttendancePage extends StatelessWidget {
  final Attendancecontroller controller = Get.put(
    Attendancecontroller(
      repo: Attendancerepo(attendanceServices: AttendanceServices()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'تسجيل الحضور'),

      body: Obx(() {
        if (!controller.networkController.isConnected.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.loadData();
            },
          );
        }
        if (controller.isloading.value) {
          return Loadingcircular();
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ◼ اختيار الفرع
                Gap(15),
                Dropdownaddemployee(
                  onChanged: (v) {
                    controller.changeBranch(v!);
                  },
                  items: controller.branches
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.name,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // خط بسيط على الشمال
                              Container(
                                width: 6,
                                height: 35,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(width: 10),
                              // النصوص
                              Text(
                                e.name,
                                style: cairoStyle(
                                  fontSize: 14,
                                  fontweight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  title: 'اختر الفرع',
                  icon: Icons.local_fire_department,
                  value: controller.selectedBranch.value?.name,
                ),
                Gap(15),
                Dropdownaddemployee(
                  onChanged: (v) {
                    controller.changeShift(v!);
                  },
                  items: controller.shifts
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.name,
                          child: BuildshiftCard(shift: e),
                        ),
                      )
                      .toList(),
                  title: 'اختر الشيفت الحاضر به',
                  icon: Icons.local_fire_department,
                  value: controller.selectedShift.value?.name,
                ),
                Gap(20),
                Buttonapp(
                  OnTap: () {
                    controller.checkIn(context);
                  },
                  text: 'تسجيل الحضور',
                  Loadingtext: 'جاري تسجيل الحضور...',
                  isloading: controller.isCheckinloading.value,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
