import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<PickerDateRange?> showDateRangePickerRes(BuildContext context) async {
  final DateRangePickerController controller = DateRangePickerController();

  controller.selectedRange = PickerDateRange(
    DateTime.now().subtract(const Duration(days: 30)),
    DateTime.now(),
  );

  PickerDateRange? result;

  await Get.dialog(
    Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Center(
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 24,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: SizedBox(
                width: isMobile ? Get.width * 0.95 : 500,
                height: isMobile ? Get.height * 0.75 : Get.height * 0.6,
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 20),
                  child: Column(
                    children: [
                      /// title
                      Text(
                        'اختر نطاق التاريخ',
                        style: cairoStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontweight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// picker
                      Expanded(
                        child: SfDateRangePicker(
                          controller: controller,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: controller.selectedRange,
                          maxDate: DateTime.now(),
                          todayHighlightColor: const Color(0xff197fe6),
                          startRangeSelectionColor: const Color(0xff197fe6),
                          endRangeSelectionColor: const Color(0xff197fe6),
                          rangeSelectionColor: const Color(
                            0xff197fe6,
                          ).withOpacity(0.25),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text('إلغاء'),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff197fe6),
                              ),
                              onPressed: () {
                                result = controller.selectedRange;
                                Get.back();
                              },
                              child: const Text('تأكيد'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );

  return result;
}
