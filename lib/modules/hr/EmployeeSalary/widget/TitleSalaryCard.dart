import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/SalaryValueContainer.dart';

class TitleSalaryCard extends StatelessWidget {
  const TitleSalaryCard({super.key, required this.salary});
  final SalaryResultModel salary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;

        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                salary.name,
                style: cairoStyle(
                  fontSize: 15.spAdaptive(context),
                  fontweight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              SalaryValueContainer(salary: salary),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                salary.name,
                style: cairoStyle(
                  fontSize: 15.spAdaptive(context),
                  fontweight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            SalaryValueContainer(salary: salary),
          ],
        );
      },
    );
  }
}
