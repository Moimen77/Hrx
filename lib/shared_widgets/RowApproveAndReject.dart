import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class RowApproveAndReject extends StatelessWidget {
  const RowApproveAndReject({
    super.key,
    required this.onApprove,
    required this.onReject,
  });
  final void Function() onApprove;
  final void Function() onReject;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 340;

        final approveButton = ElevatedButton.icon(
          icon: Icon(Icons.check, size: 18.spAdaptive(context)),
          label: Text(
            'قبول',
            style: cairoStyle(
              fontcolor: Colors.white,
              fontSize: 13.spAdaptive(context),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 12.spAdaptive(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => onApprove(),
        );

        final rejectButton = ElevatedButton.icon(
          icon: Icon(Icons.close, size: 18.spAdaptive(context)),
          label: Text(
            'رفض',
            style: cairoStyle(
              fontcolor: Colors.white,
              fontSize: 13.spAdaptive(context),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 12.spAdaptive(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => onReject(),
        );

        if (isCompact) {
          return Column(
            children: [
              SizedBox(width: double.infinity, child: approveButton),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: rejectButton),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: approveButton),
            const SizedBox(width: 12),
            Expanded(child: rejectButton),
          ],
        );
      },
    );
  }
}
