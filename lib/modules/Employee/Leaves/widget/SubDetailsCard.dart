import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
        borderRadius: BorderRadius.circular(10.spAdaptive(context)),
        side: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubEmpText(),
            SizedBox(height: controller.Ismanger ? 0 : 20.spAdaptive(context)),
            !(controller.Ismanger)
                ? const MangerDropdown()
                : const SizedBox.shrink(),
            SizedBox(height: 20.spAdaptive(context)),
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
                  SizedBox(height: 20.spAdaptive(context)),
                  (!controller.isAllEmployeesSelected.value)
                      ? const SubEmployeesDrowdown()
                      : const AllEmployeesSelected(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
