import 'package:flutter/material.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/EmpAttendance/view/BranchDropfilter.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/ActionFilterButtons.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/DateFilters.dart';
import 'package:hrx/modules/Employee/EmpAttendance/widget/StatusFilter.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/FilterCard.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final filtersBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BranchDropFilter(),
        SizedBox(height: 12.spAdaptive(context)),
        const StatusFilter(),
        SizedBox(height: 12.spAdaptive(context)),
        const DateFilters(),
        SizedBox(height: 12.spAdaptive(context)),
        const ActionFilterButtons(),
      ],
    );

    if (isDesktop) {
      return Filtercard(
        child: ListView(
          children: [
            Text(
              'خيارات الفلترة',
              style: cairoStyle(
                fontweight: FontWeight.bold,
                fontSize: 16.spAdaptive(context),
              ),
            ),
            SizedBox(height: 14.spAdaptive(context)),
            filtersBody,
          ],
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 14.spAdaptive(context)),
          childrenPadding: EdgeInsets.fromLTRB(
            14.spAdaptive(context),
            0,
            14.spAdaptive(context),
            14.spAdaptive(context),
          ),
          title: Text(
            'خيارات الفلترة',
            style: cairoStyle(
              fontweight: FontWeight.bold,
              fontSize: 15.spAdaptive(context),
            ),
          ),
          children: [filtersBody],
        ),
      ),
    );
  }
}
