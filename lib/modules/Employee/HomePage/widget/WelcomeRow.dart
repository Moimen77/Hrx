import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/routes/app_pages.dart';

class WelcomeRow extends GetView<Homepagecontroller> {
  const WelcomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = controller.Employee;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.3, color: const Color(0xff1e293b)),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                (employee?.imageUrl != null && employee!.imageUrl!.isNotEmpty)
                ? NetworkImage(employee.imageUrl!)
                : null,
            child: (employee?.imageUrl == null || employee!.imageUrl!.isEmpty)
                ? const Icon(Icons.person)
                : null,
          ),
        ),
        const Gap(8),
        Expanded(
          child: Text(
            'أهلا , ${employee?.name ?? ''}',
            overflow: TextOverflow.ellipsis,
            style: cairoStyle(fontweight: FontWeight.bold, fontSize: 17),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.substitute);
              },
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Appcolors.warning,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    width: 1.2,
                    color: const Color(0xff1e293b),
                  ),
                ),
                child: const Icon(
                  Icons.record_voice_over_outlined,
                  color: Color(0xff1e293b),
                  size: 22,
                ),
              ),
            ),

            /// Badge
            if (controller.padgeCount > 0)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.padgeCount > 99
                        ? "99+"
                        : controller.padgeCount.toString(),
                    style: cairoStyle(fontcolor: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
