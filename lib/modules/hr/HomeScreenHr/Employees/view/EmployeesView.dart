import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/EmployeesController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeScreen/EmployeePageColumnData.dart';
import 'package:hrx/shared_widgets/CustomRefresh.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class EmployeesListView extends StatelessWidget {
  final EmployeesController controller = Get.find<EmployeesController>();
  EmployeesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() {
        if (controller.hasError.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.loadEmployees();
            },
          );
        }
        if (controller.loading.value) {
          return Loadingcircular();
        }
        return CustomRefreshWrapper(
          onRefresh: () async {
            await controller.loadEmployees();
          },
          child: Employeepagecolumndata(),
        );
      }),
    );
  }
}
