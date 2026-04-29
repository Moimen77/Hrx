import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Leaves/widget/AllEmployeesSelected.dart';
import 'package:hrx/modules/Employee/Leaves/widget/selectAllEmployeeRow.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/form_helpers.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/DropDownAddEmployee.dart';

class SubstituteEmployeeSelector extends GetView<PermissionRequestController> {
  const SubstituteEmployeeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.isallEmployeeSelected.value
              ? AllEmployeesSelected()
              : Container(
                  decoration: formBoxDecoration(),
                  child: Dropdownaddemployee(
                    value: controller.selectedSubstituteId.value?.toString(),
                    onChanged: (val) => controller.selectedSubstituteId.value =
                        int.tryParse(val!),
                    items: controller.employees
                        .where(
                          (emp) =>
                              emp.isManger == false &&
                              emp.departmentId ==
                                  controller.Currentdepartmentid,
                        )
                        .map(
                          (emp) => DropdownMenuItem<String>(
                            value: emp.id.toString(),
                            child: Text(emp.name ?? '', style: cairoStyle()),
                          ),
                        )
                        .toList(),
                    title: 'اختر الموظف البديل',
                    icon: Icons.person_search_outlined,
                  ),
                ),
        ),
        Obx(
          () => SelectAllEmployeeRow(
            onTap: () {
              controller.isallEmployeeSelected.value =
                  !controller.isallEmployeeSelected.value;
            },
            isactive: controller.isallEmployeeSelected.value,
          ),
        ),
      ],
    );
  }
}
