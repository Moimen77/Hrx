import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/AllEmployeesSelected.dart';
import 'package:hrx/modules/Employee/Leaves/widget/MangerDropDown.dart';
import 'package:hrx/modules/Employee/Leaves/widget/SubEmpText.dart';
import 'package:hrx/modules/Employee/Leaves/widget/SubEmployeesDrowDown.dart';
import 'package:hrx/modules/Employee/Leaves/widget/selectAllEmployeeRow.dart';

class SubDetailsCard extends GetView<LeaveController> {
  const SubDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      color: Colors.white,
      shadowColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubEmpText(),
            SizedBox(height: controller.Ismanger ? 0 : 20),
            !(controller.Ismanger) ? MangerDropdown() : SizedBox.shrink(),
            SizedBox(height: 20),
            Obx(
              () => Column(
                children: [
                  SelectAllEmployeeRow(
                    isactive: controller.isAllEmployeesSelected.value,
                    onTap: () {
                      {
                        controller.isAllEmployeesSelected.value =
                            !controller.isAllEmployeesSelected.value;
                        if (controller.isAllEmployeesSelected.value) {
                          controller.selectedEmployee.value = null;
                        }
                      }
                    },
                  ),
                  (!controller.isAllEmployeesSelected.value)
                      ? SubEmployeesDrowdown()
                      : AllEmployeesSelected(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
