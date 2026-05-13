import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/substitute/widget/ApproveSubtituation.dart';
import 'package:hrx/modules/Employee/substitute/widget/RejectSubtituationButton.dart';

class ActionSubtitutationButtons extends StatelessWidget {
  const ActionSubtitutationButtons({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    final isWide =
        Responsive.isDesktop(context) || Responsive.isTablet(context);

    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: ApproveSubtituationButton(leave: leave)),
          SizedBox(width: 12.spAdaptive(context)),
          const Expanded(child: RejectSubtituationButton()),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ApproveSubtituationButton(leave: leave),
        SizedBox(height: 10.spAdaptive(context)),
        const RejectSubtituationButton(),
      ],
    );
  }
}
