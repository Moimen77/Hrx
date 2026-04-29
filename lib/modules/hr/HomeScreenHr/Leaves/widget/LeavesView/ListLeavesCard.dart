import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/LeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/LeavesView/LeaveCard.dart';

class Listleavescard extends GetView<LeaveController> {
  const Listleavescard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.leaves.length + 1,
        itemBuilder: (context, index) {
          // نهاية القائمة
          if (index == controller.leaves.length) {
            if (controller.isLoadingMore.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        "جاري تحميل المزيد...",
                        style: cairoStyle(
                          fontSize: 16,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (controller.noMoreData.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text("لا توجد المزيد من البيانات")),
              );
            } else {
              return const SizedBox(height: 80);
            }
          }

          final leave = controller.leaves[index];
          return Leavecard(leave: leave);
        },
      );
    });
  }
}
