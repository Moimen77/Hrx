import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart' show Obx, GetView;
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';

enum EnAcOrRej { approve, reject }

class Buttonaddorrejected extends GetView<LeaveController> {
  const Buttonaddorrejected(this.leave, this.action, {super.key});
  final LeaveModel leave;
  final EnAcOrRej action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.updateLeaveStatus(leave, context, action),
      child: Obx(
        () => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 10.spAdaptive(context),
            vertical: 10.spAdaptive(context),
          ),
          decoration: BoxDecoration(
            color: const Color(0xfffdedeb),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ((action == EnAcOrRej.approve
                      ? controller.isloadedApproved.value
                      : controller.isloadedrejected.value) &&
                  (leave.id == controller.currentUpdateLoadingLeaveID.value))
              ? Loadingcircular()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      action == EnAcOrRej.approve ? "قبول" : "رفض",
                      style: cairoStyle(
                        fontSize: 15.spAdaptive(context),
                        fontweight: FontWeight.w600,
                        fontcolor: const Color(0xffea6659),
                      ),
                    ),
                    const Gap(5),
                    Icon(
                      action == EnAcOrRej.approve
                          ? Icons.handshake_rounded
                          : Icons.back_hand_rounded,
                      size: 17.spAdaptive(context),
                      color: const Color(0xffea6659),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
