import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/HrInfo.dart';

class HrInfoHeader extends GetView<Hrcontroller> {
  const HrInfoHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade300],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: isDesktop
          ? Column(
              children: [
                _buildAvatar(context),
                const Gap(12),
                const Hrinfo(useExpanded: false, textAlign: TextAlign.center),
              ],
            )
          : Row(children: [_buildAvatar(context), const Gap(12), Hrinfo()]),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: CircleAvatar(
            radius: 26.spAdaptive(context),
            backgroundImage: controller.data['image'] != null
                ? NetworkImage(controller.data['image'])
                : null,
            child: controller.data['image'] == null
                ? Icon(Icons.person, size: 30.spAdaptive(context))
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await controller.pickAndUploadImage();
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 4, 125, 125),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: 13.spAdaptive(context),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
