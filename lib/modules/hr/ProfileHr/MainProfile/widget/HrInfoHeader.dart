import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Hr/Controller/HrController.dart';
import 'package:hrx/modules/hr/ProfileHr/MainProfile/widget/HrInfo.dart';

class HrInfoHeader extends GetView<Hrcontroller> {
  const HrInfoHeader({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: controller.data['image'] != null
                      ? NetworkImage(controller.data['image'])
                      : null,
                  child: controller.data['image'] == null
                      ? const Icon(Icons.person, size: 30)
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
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 125, 125),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Hrinfo(),
        ],
      ),
    );
  }
}
