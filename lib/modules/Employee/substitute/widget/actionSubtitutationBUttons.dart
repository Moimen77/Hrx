import 'package:flutter/widgets.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/substitute/widget/ApproveSubtituation.dart';
import 'package:hrx/modules/Employee/substitute/widget/RejectSubtituationButton.dart';

class ActionSubtitutationButtons extends StatelessWidget {
  const ActionSubtitutationButtons({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ApproveSubtituationButton(leave: leave),
        RejectSubtituationButton(),
      ],
    );
  }
}
