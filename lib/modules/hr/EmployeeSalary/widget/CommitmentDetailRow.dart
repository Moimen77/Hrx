import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class CommitmentDetailRow extends StatelessWidget {
  const CommitmentDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.isSuccess,
  });
  final String label;
  final String value;
  final bool? isSuccess;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSuccess == null
            ? SizedBox.shrink()
            : Icon(
                isSuccess! ? Icons.check_circle : Icons.cancel,
                color: isSuccess! ? Colors.green : Colors.red,
                size: 14,
              ),
        const SizedBox(width: 6),
        Text(
          "$label: $value",
          style: cairoStyle(
            fontSize: 12,
            fontcolor: isSuccess != null ? Colors.grey : Colors.red,
          ),
        ),
      ],
    );
  }
}
