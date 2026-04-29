import 'package:flutter/material.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/DateAndDepartmentFilter.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/SearchFieldAteedance.dart';

class Attendancefilters extends StatelessWidget {
  const Attendancefilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Searchfieldateedance(),
        const SizedBox(height: 16),
        Dateanddepartmentfilter(),
      ],
    );
  }
}
