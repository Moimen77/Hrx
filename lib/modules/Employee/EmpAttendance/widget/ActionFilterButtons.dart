import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/ClearFiltersButton.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class ActionFilterButtons extends GetView<AttendanceArciveController> {
  const ActionFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = Responsive.isDesktop(context);

    final applyButton = Buttonapp(
      text: 'تطبيق',
      OnTap: () {
        controller.applyFilter();
      },
      Loadingtext: '',
      isloading: false,
    );

    if (!isWide) {
      return Row(
        children: [
          Expanded(child: applyButton),
          SizedBox(width: 10.spAdaptive(context)),
          Expanded(child: const ClearFiltersButton()),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(width: double.infinity, child: applyButton),
        SizedBox(height: 10.spAdaptive(context)),
        SizedBox(width: double.infinity, child: const ClearFiltersButton()),
      ],
    );
  }
}
