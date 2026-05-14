import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class SelectAllEmployeeRow extends StatelessWidget {
  const SelectAllEmployeeRow({
    super.key,
    required this.onTap,
    required this.isactive,
  });
  final void Function()? onTap;
  final bool isactive;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(
            isactive ? Icons.check_box : Icons.check_box_outline_blank,
            color: Appcolors.primarycolor,
            size: 20.spAdaptive(context),
          ),
          label: Text(
            "تحديد كل الموظفين",
            style: cairoStyle(
              fontSize: 14.spAdaptive(context),
              fontcolor: Appcolors.primarycolor,
            ),
          ),
        ),
      ],
    );
  }
}
