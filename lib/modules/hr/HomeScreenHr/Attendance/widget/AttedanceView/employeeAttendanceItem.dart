import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/attendance_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/openBottomSheet.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/AttedanceView/statusBadge.dart';

class Employeeattendanceitem extends StatelessWidget {
  const Employeeattendanceitem({super.key, required this.item});
  final EmployeeDayModel item;

  @override
  Widget build(BuildContext context) {
    String? checkIn = item.checkIn != null
        ? formatTimeToArabic(
            item.checkIn!.subtract(Duration(hours: 2)).toIso8601String(),
          )
        : '';
    String checkOut = item.checkOut != null
        ? formatTimeToArabic(
            item.checkOut!.subtract(Duration(hours: 2)).toIso8601String(),
          )
        : '';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.spAdaptive(context),
                backgroundColor: Colors.grey.shade200,
                backgroundImage: item.profileImage != null
                    ? NetworkImage(item.profileImage!)
                    : null,
                child: item.profileImage == null
                    ? Icon(Icons.person, color: Colors.grey.shade600)
                    : null,
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.employeeName,
                      style: cairoStyle(fontweight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Text(
                        (checkIn == '' && checkOut == '')
                            ? ''
                            : ' الدخول : $checkIn \n الخروج : $checkOut',
                        maxLines: 2,
                        style: cairoStyle(
                          fontSize: 12.spAdaptive(context),
                          fontcolor: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Statusbadge(attendance: item),
                  TextButton(
                    onPressed: () => _showSyncfusionDateRangePicker(context),
                    child: Text(
                      'التفاصيل',
                      style: cairoStyle(
                        fontcolor: Colors.blue.shade900,
                        fontweight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              // الاسم + دخول + خروج
            ],
          ),
          // فاصل تحت الكارد
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  void _showSyncfusionDateRangePicker(BuildContext context) {
    final DateRangePickerController controller = DateRangePickerController();
    controller.selectedRange = PickerDateRange(
      DateTime.now().subtract(const Duration(days: 30)),
      DateTime.now(),
    );

    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.6,
              maxWidth: 500.spAdaptive(context), // Good for tablets
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'اختر نطاق التاريخ',
                    style: cairoStyle(
                      fontSize: 18.spAdaptive(context),
                      fontweight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: SfDateRangePicker(
                      controller: controller,
                      selectionMode: DateRangePickerSelectionMode.range,
                      view: DateRangePickerView.month,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 6,
                      ), // Saturday
                      initialSelectedRange: controller.selectedRange,
                      maxDate: DateTime.now(),
                      headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: cairoStyle(
                          fontweight: FontWeight.bold,
                          fontSize: 16.spAdaptive(context),
                        ),
                      ),
                      selectionTextStyle: cairoStyle(
                        fontcolor: Colors.white,
                        fontSize: 12.spAdaptive(context),
                      ),
                      rangeTextStyle: cairoStyle(
                        fontcolor: Colors.white,
                        fontSize: 12.spAdaptive(context),
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: cairoStyle(fontSize: 12),
                        todayTextStyle: cairoStyle(
                          fontcolor: const Color(0xff197fe6),
                        ),
                      ),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        textStyle: cairoStyle(),
                        todayTextStyle: cairoStyle(
                          fontcolor: const Color(0xff197fe6),
                        ),
                      ),
                      rangeSelectionColor: const Color(
                        0xff197fe6,
                      ).withOpacity(0.3),
                      startRangeSelectionColor: const Color(0xff197fe6),
                      endRangeSelectionColor: const Color(0xff197fe6),
                      todayHighlightColor: const Color(0xff197fe6),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff197fe6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            final range = controller.selectedRange;
                            if (range?.startDate != null) {
                              Get.back();
                              final endDate =
                                  range?.endDate ?? range!.startDate!;
                              final items =
                                  await Get.find<AttendanceController>()
                                      .getEmployeeDays(
                                        item.employeeId,
                                        range!.startDate!,
                                        endDate,
                                      );
                              openBottomSheet(items);
                            }
                          },
                          child: Text(
                            'تأكيد',
                            style: cairoStyle(
                              fontcolor: Colors.white,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
