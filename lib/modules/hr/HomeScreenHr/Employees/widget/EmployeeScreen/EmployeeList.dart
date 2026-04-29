import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmployeeCard.dart';

class Employeelist extends GetView<EmployeesController> {
  const Employeelist({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final filteredList = controller.filteredEmployees;
        if (filteredList.isEmpty) {
          return Center(
            child: Text(
              "لا يوجد موظفين مطابقين للبحث",
              style: cairoStyle(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final emp = filteredList[index];
            return EmployeeCard(employee: emp);
          },
        );
      }),
    );
  }
}
