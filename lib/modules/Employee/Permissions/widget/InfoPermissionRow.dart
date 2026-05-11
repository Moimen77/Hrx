import 'package:flutter/material.dart';
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
      padding: EdgeInsets.only(bottom: 8.spAdaptive(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.spAdaptive(context), color: Colors.grey.shade600),
          SizedBox(width: 10.spAdaptive(context)),
          Text(
            '$label: ',
            style: cairoStyle(
              fontSize: 14.spAdaptive(context),
              fontcolor: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: cairoStyle(
                fontSize: 14.spAdaptive(context),
                fontweight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
