import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/EmpAttendance/controller/AttendanceArchiveController.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/ClearFiltersButton.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class ActionFilterButtons extends GetView<AttendanceArciveController> {
  const ActionFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Buttonapp(
            text: 'تطبيق',
            OnTap: () {
              controller.applyFilter();
            },
            Loadingtext: '',
            isloading: false,
          ),
        ),
        const SizedBox(width: 10),
        ClearFiltersButton(),
      ],
    );
  }
}
