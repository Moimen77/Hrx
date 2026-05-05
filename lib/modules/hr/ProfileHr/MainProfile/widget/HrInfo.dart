import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';

class Hrinfo extends GetView<Hrcontroller> {
  const Hrinfo({super.key, this.useExpanded = true, this.textAlign});

  final bool useExpanded;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          controller.data['name'] ?? '',
          textAlign: textAlign,
          style: cairoStyle(
            fontSize: 16.spAdaptive(context),
            fontweight: FontWeight.bold,
            fontcolor: Colors.white,
          ),
        ),
        const Gap(3),
        Text(
          controller.data['role'] ?? '',
          textAlign: textAlign,
          style: cairoStyle(
            fontSize: 13.spAdaptive(context),
            fontweight: FontWeight.w600,
            fontcolor: Colors.white70,
          ),
        ),
      ],
    );

    if (useExpanded && !Responsive.isDesktop(context)) {
      return Expanded(child: content);
    }

    return content;
  }
}
