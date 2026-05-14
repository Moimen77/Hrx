import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/LeaveRequestDetails.dart';
import 'package:hrx/modules/Employee/Leaves/widget/RequestLeaveButton.dart';
import 'package:hrx/modules/Employee/Leaves/widget/SubDetailsCard.dart';

class LeavePageForm extends GetView<LeaveController> {
  const LeavePageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop
              ? 1300
              : isTablet
              ? 900
              : double.infinity,
        ),
        child: Padding(
          padding: EdgeInsets.all(isDesktop ? 24 : 16),
          child: Form(
            key: controller.formKey,
            child: Directionality(
              textDirection: ui.TextDirection.rtl,
              child: ListView(
                children: [
                  SizedBox(height: 10.spAdaptive(context)),
                  isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: LeaveRequestDetails()),
                            SizedBox(width: 20),
                            const Expanded(flex: 2, child: SubDetailsCard()),
                          ],
                        )
                      : const Column(
                          children: [
                            LeaveRequestDetails(),
                            SizedBox(height: 10),
                            SubDetailsCard(),
                          ],
                        ),
                  SizedBox(height: 14.spAdaptive(context)),
                  const RequestLeaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
