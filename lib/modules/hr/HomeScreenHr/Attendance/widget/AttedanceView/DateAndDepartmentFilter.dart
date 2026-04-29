import 'package:flutter/material.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/DateTimePickerField.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/DropDownDepartmentList.dart';

class Dateanddepartmentfilter extends StatelessWidget {
  const Dateanddepartmentfilter({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmall = constraints.maxWidth < 310;
        double width = isSmall
            ? constraints.maxWidth
            : (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Datetimepickerfield(width),
            // DEPARTMENTS DROPDOWN
            Dropdowndepartmentlist(width: width),
          ],
        );
      },
    );
  }
}
