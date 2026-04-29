import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SectionLabel.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class DirectManagerSelector extends GetView<PermissionRequestController> {
  const DirectManagerSelector({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.ismangaer) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Sectionlabel(title: 'الموظف المباشر'),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            decoration: formBoxDecoration(),
            child: Dropdownaddemployee(
              value: controller.selectedManagerId.value?.toString(),
              onChanged: (val) =>
                  controller.selectedManagerId.value = int.tryParse(val!),
              items: controller.employees
                  .where(
                    (emp) =>
                        emp.isManger == true &&
                        emp.departmentId == controller.Currentdepartmentid,
                  )
                  .map(
                    (emp) => DropdownMenuItem<String>(
                      value: emp.id.toString(),
                      child: Text(emp.name ?? '', style: cairoStyle()),
                    ),
                  )
                  .toList(),
              title: 'اختر المدير',
              icon: Icons.manage_accounts_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
