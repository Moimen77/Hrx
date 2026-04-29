import 'package:flutter/material.dart';
import 'package:hrx/modules/Employee/Leaves/widget/FromToLeaveDate.dart';
import 'package:hrx/modules/Employee/Leaves/widget/LeaveTypeDropDown.dart';
import 'package:hrx/modules/Employee/Leaves/widget/ReasonTextFormField.dart';
import 'package:hrx/modules/Employee/Leaves/widget/RequestDetailsText.dart';

class LeaveRequestDetails extends StatelessWidget {
  const LeaveRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      color: Colors.white,
      shadowColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequestDetailsText(),
            SizedBox(height: 20),
            LeaveTypeDropdown(),
            SizedBox(height: 20),
            FromToLeaveDate(),
            ReasonTextFormField(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
