import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddEmployeeController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/transaction_type_enum.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddRaiseDialog.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/view/AddpenaltyScreen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/view/employee_documents_screen.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmployeeActionButton.dart';
import 'package:hrx/routes/app_pages.dart';

class EmployeeActionRow extends StatelessWidget {
  const EmployeeActionRow({super.key, required this.employee});
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EmployeeActionButton(
          icon: Icons.remove_circle_outline,
          label: 'خصم',
          onTap: () {
            Get.to(
              () => const AddTransactionScreen(),
              arguments: {
                'employee': employee,
                'type': TransactionType.penalty,
              },
              transition: Transition.downToUp,
            );
          },
        ),
        EmployeeActionButton(
          icon: Icons.add_card_outlined,
          label: 'مكافأة',
          onTap: () {
            Get.to(
              () => const AddTransactionScreen(),
              arguments: {'employee': employee, 'type': TransactionType.bonus},
              transition: Transition.downToUp,
            );
          },
        ),
        EmployeeActionButton(
          icon: Icons.document_scanner_outlined,
          label: 'المستندات',
          onTap: () {
            Get.to(() => const EmployeeDocumentsScreen(), arguments: employee);
          },
        ),
        employee.employeeType != 'shifts'
            ? EmployeeActionButton(
                icon: Icons.attach_money,
                label: 'زيادة سنوية',
                onTap: () {
                  Get.dialog(AddRaiseDialog(employee: employee));
                },
              )
            : SizedBox(width: 0),
        EmployeeActionButton(
          icon: Icons.edit_outlined,
          label: 'تعديل',
          onTap: () {
            Get.toNamed(
              AppRoutes.addEmployee,
              arguments: {'mode': EmployeeViewMode.edit, 'employee': employee},
            );
          },
        ),
      ],
    );
  }
}
