import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/DirectManagerSelector.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/NotesTextField.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/PermissionDateSelector.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/PermissionTypeDropdown.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SectionLabel.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SubmitPermissionButton.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/SubstituteEmployeeSelector.dart';

class PermissionPageForm extends GetView<PermissionRequestController> {
  const PermissionPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isWide = isDesktop || isTablet;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop
              ? 1150
              : isTablet
              ? 900
              : double.infinity,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            isDesktop ? 24.spAdaptive(context) : 16.spAdaptive(context),
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _FormSection(
                          title: 'نوع الإذن',
                          child: const PermissionTypeDropdown(),
                        ),
                      ),
                      SizedBox(width: 16.spAdaptive(context)),
                      Expanded(
                        child: _FormSection(
                          title: 'تاريخ الإذن',
                          child: const PermissionDateSelector(),
                        ),
                      ),
                    ],
                  )
                else ...[
                  const Sectionlabel(title: 'نوع الإذن'),
                  SizedBox(height: 8.spAdaptive(context)),
                  const PermissionTypeDropdown(),
                  SizedBox(height: 20.spAdaptive(context)),
                  const Sectionlabel(title: 'تاريخ الإذن'),
                  SizedBox(height: 8.spAdaptive(context)),
                  const PermissionDateSelector(),
                ],
                SizedBox(height: 20.spAdaptive(context)),
                const Sectionlabel(title: 'الموظف البديل'),
                SizedBox(height: 10.spAdaptive(context)),
                const SubstituteEmployeeSelector(),
                SizedBox(height: 20.spAdaptive(context)),
                const DirectManagerSelector(),
                SizedBox(height: 20.spAdaptive(context)),
                const Sectionlabel(title: 'ملاحظات'),
                SizedBox(height: 8.spAdaptive(context)),
                const NotesTextField(),
                SizedBox(height: 30.spAdaptive(context)),
                const SubmitPermissionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Sectionlabel(title: title),
        SizedBox(height: 8.spAdaptive(context)),
        child,
      ],
    );
  }
}
