import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class InfoPermissionRow extends StatelessWidget {
  const InfoPermissionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.spAdaptive(context), color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: cairoStyle(
              fontSize: 13.spAdaptive(context),
              fontcolor: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: cairoStyle(
                fontSize: 13.spAdaptive(context),
                fontweight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
