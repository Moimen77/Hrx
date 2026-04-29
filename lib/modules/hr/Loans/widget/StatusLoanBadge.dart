import 'package:flutter/material.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class StatusLoanBadge extends StatelessWidget {
  const StatusLoanBadge(
    BuildContext context, {
    super.key,
    required this.status,
  });

  final String? status;

  Color _getStatusColor(String statusValue) {
    switch (statusValue) {
      case 'مقبولة':
        return Colors.green;
      case 'مرفوضة':
        return Colors.red;
      case 'معلقة':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = status ?? 'غير محدد';
    final color = _getStatusColor(label);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.spAdaptive(context),
        vertical: 4.spAdaptive(context),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: cairoStyle(
          fontcolor: Colors.white,
          fontSize: 12.spAdaptive(context),
        ),
      ),
    );
  }
}
