import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/employeeDayModel.dart';

void openBottomSheet(List<EmployeeDayModel> items) {
  Get.bottomSheet(
    Container(
      height: Get.height * 0.7,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "سجل الحضور",
            style: cairoStyle(fontSize: 18, fontweight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "التاريخ",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontweight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "الدخول",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontweight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "الخروج",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontweight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "الحالة",
                    textAlign: TextAlign.center,
                    style: cairoStyle(
                      fontweight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Table Body
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("لا توجد بيانات"))
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                TimeHelper.formatDateToArabic(item.date),
                                textAlign: TextAlign.center,
                                style: cairoStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.checkIn != null
                                    ? TimeHelper.formatToArabicTime(
                                        item.checkIn!,
                                      )
                                    : "-",
                                textAlign: TextAlign.center,
                                style: cairoStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.checkOut != null
                                    ? TimeHelper.formatToArabicTime(
                                        item.checkOut!,
                                      )
                                    : "-",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(item).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _translateStatus(item),
                                  textAlign: TextAlign.center,
                                  style: cairoStyle(
                                    fontSize: 11,
                                    fontweight: FontWeight.bold,
                                    fontcolor: _getStatusColor(item),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

Color _getStatusColor(EmployeeDayModel item) {
  switch (item.status.toLowerCase()) {
    case 'present':
      return Colors.green;
    case 'absent':
      return Colors.red;
    case 'late':
      return Colors.orange;
    case 'leave':
      if (item.hr_leave_approve != 'موافقة') return Colors.red;
      return Colors.blue;
    case 'friday':
      if (item.checkIn != null || item.checkOut != null) {
        return Colors.purple;
      }
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

String _translateStatus(EmployeeDayModel item) {
  switch (item.status.toLowerCase()) {
    case 'present':
      if (item.permission_minute > 0) return 'إذن';
      return 'حاضر';
    case 'absent':
      if (item.employeeType != 'full_time') {
        return 'لم يسجل';
      } else {
        return 'غياب دون إذن';
      }
    case 'late':
      return 'تأخير';
    case 'leave':
      if (item.hr_leave_approve != 'موافقة') {
        if (item.checkIn == null) {
          return 'غياب دون إذن';
        }
        return 'حضور';
      }
      return 'أجازة';
    case 'friday':
      if (item.checkIn != null || item.checkOut != null) {
        return 'جمعة * 2';
      }
      return 'جمعة';
    case 'thursday':
      return 'خميس';
    case 'official_holiday':
      return 'اجازة رسمية';
    default:
      return item.status;
  }
}
