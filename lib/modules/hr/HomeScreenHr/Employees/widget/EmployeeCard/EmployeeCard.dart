import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmailAndNameEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmployeeActionRow.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/EmployeeCard/EmployeeInformation.dart';
import 'package:hrx/shared_widgets/ImageCirularAvatar.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shadowColor: Appcolors.primarycolor.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Imagecirularavatar(
                    imageUrl: employee.imageUrl,
                    icon: Icons.person_outline_outlined,
                  ),
                  const Gap(12),
                  Emailandnameemployee(employee: employee),
                ],
              ),
              const Divider(height: 24),
              Employeeinformation(employee: employee),
              const Divider(height: 24),
              EmployeeActionRow(employee: employee),
            ],
          ),
        ),
      ),
    );
  }
}
