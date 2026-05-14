import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class RequestDetailsText extends StatelessWidget {
  const RequestDetailsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Appcolors.primarycolor,
          size: 22.spAdaptive(context),
        ),
        SizedBox(width: 8.spAdaptive(context)),
        Text(
          "تفاصيل الطلب",
          style: cairoStyle(
            fontSize: 18.spAdaptive(context),
            fontweight: FontWeight.bold,
            fontcolor: Appcolors.primarycolor,
          ),
        ),
      ],
    );
  }
}
