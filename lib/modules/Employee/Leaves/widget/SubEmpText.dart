import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class SubEmpText extends StatelessWidget {
  const SubEmpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.people_alt_outlined,
          color: Appcolors.primarycolor,
          size: 22,
        ),
        SizedBox(width: 8),
        Text(
          "اختيار بديل",
          style: cairoStyle(
            fontSize: 18,
            fontweight: FontWeight.bold,
            fontcolor: Appcolors.primarycolor,
          ),
        ),
      ],
    );
  }
}
