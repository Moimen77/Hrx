import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_controller.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class OfficialHolidaysView extends GetView<OfficialHolidaysController> {
  const OfficialHolidaysView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.networkController.isConnected.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchHolidays();
          },
        );
      }

      if (controller.isLoading.value ||
          controller.networkController.isChecking.value) {
        return Loadingcircular();
      }

      if (controller.holidays.isEmpty) {
        return Center(
          child: Text(
            "لا توجد عطلات مسجلة",
            style: cairoStyle(fontSize: 18, fontweight: FontWeight.w600),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: controller.holidays.length,
        itemBuilder: (context, index) {
          final holiday = controller.holidays[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(.05),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                /// Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.celebration, color: Colors.blue),
                ),

                const SizedBox(width: 16),

                /// Holiday Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holiday.name,
                        style: cairoStyle(
                          fontSize: 16,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        holiday.isRecurring
                            ? "كل سنة في ${holiday.day}/${holiday.month}"
                            : "التاريخ: ${holiday.holidayDate.toString().split(' ')[0]}",
                        style: cairoStyle(
                          fontSize: 13,
                          fontcolor: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Type Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: holiday.isRecurring
                        ? Colors.green.withOpacity(.15)
                        : Colors.orange.withOpacity(.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    holiday.isRecurring ? "سنوية" : "مرة واحدة",
                    style: cairoStyle(
                      fontSize: 12,
                      fontweight: FontWeight.w600,
                      fontcolor: holiday.isRecurring
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                /// Delete Button
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => controller.deleteHoliday(holiday.id!),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
