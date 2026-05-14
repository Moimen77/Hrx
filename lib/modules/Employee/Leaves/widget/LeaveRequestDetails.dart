import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
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
        borderRadius: BorderRadius.circular(10.spAdaptive(context)),
        side: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.spAdaptive(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RequestDetailsText(),
            SizedBox(height: 20.spAdaptive(context)),
            const LeaveTypeDropdown(),
            SizedBox(height: 20.spAdaptive(context)),
            const FromToLeaveDate(),
            const ReasonTextFormField(),
            SizedBox(height: 10.spAdaptive(context)),
          ],
        ),
      ),
    );
  }
}
