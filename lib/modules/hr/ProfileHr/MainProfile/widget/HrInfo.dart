import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';

class Hrinfo extends GetView<Hrcontroller> {
  const Hrinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.data['name'] ?? '',
            style: cairoStyle(
              fontSize: 16.spAdaptive(context),
              fontweight: FontWeight.bold,
              fontcolor: Colors.white,
            ),
          ),
          const Gap(3),
          Text(
            controller.data['role'] ?? '',
            style: cairoStyle(
              fontSize: 13.spAdaptive(context),
              fontweight: FontWeight.w600,
              fontcolor: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
