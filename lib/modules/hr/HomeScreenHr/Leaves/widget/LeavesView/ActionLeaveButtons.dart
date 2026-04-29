import 'package:flutter/material.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/ButtonAddOrRejected.dart';

class Actionleavebuttons extends StatelessWidget {
  const Actionleavebuttons({super.key, required this.leave});
  final LeaveModel leave;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;

        return Column(
          children: [
            const SizedBox(height: 10),
            const Divider(),
            if (isCompact) ...[
              Buttonaddorrejected(leave, EnAcOrRej.reject),
              const SizedBox(height: 8),
              Buttonaddorrejected(leave, EnAcOrRej.approve),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Buttonaddorrejected(leave, EnAcOrRej.reject)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Buttonaddorrejected(leave, EnAcOrRej.approve),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
