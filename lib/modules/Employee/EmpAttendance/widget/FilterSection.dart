import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmpAttendance/view/BranchDropfilter.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/ActionFilterButtons.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/DateFilters.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/StatusFilter.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ExpansionTile(
          title: Text(
            'خيارات الفلترة',
            style: cairoStyle(fontweight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  BranchDropFilter(),
                  const SizedBox(height: 10),
                  StatusFilter(),
                  const SizedBox(height: 10),
                  DateFilters(),
                  const SizedBox(height: 10),
                  ActionFilterButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
