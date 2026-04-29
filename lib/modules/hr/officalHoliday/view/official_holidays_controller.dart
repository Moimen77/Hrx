import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/constant/ScreenSize.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/offical_holiday.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_repo.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';

class OfficialHolidaysController extends GetxController {
  OfficialHolidaysRepo repo;
  OfficialHolidaysController(this.repo);

  var holidays = <HolidayModel>[].obs;
  var isLoading = false.obs;

  final networkController = Get.find<NetworkController>();

  // حقول الإدخال للإضافة
  final nameController = TextEditingController();
  var isRecurring = false.obs;
  var selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    isLoading.value = true;
    try {
      if (!networkController.isConnected.value) {
        return;
      }
      holidays.value = await repo.getHolidays();
    } catch (e) {
      // يفضل استخدام دالة snackbar موجودة لديك
      AppSnack.error("خطأ", "فشل تحميل العطلات");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addHoliday(HolidayModel holiday) async {
    try {
      if (!networkController.isConnected.value) {
        Get.back();
        AppSnack.error("خطأ", "لا يوجد اتصال بالإنترنت");
        return;
      }
      await repo.addHoliday(holiday);
      fetchHolidays(); // تحديث القائمة
      Get.back(); // إغلاق الـ Dialog
      AppSnack.success("نجاح", "تم إضافة العطلة بنجاح");
    } catch (e) {
      AppSnack.error("خطأ", "فشل إضافة العطلة");
    }
  }

  Future<void> deleteHoliday(int id) async {
    try {
      if (!networkController.isConnected.value) {
        AppSnack.error("خطأ", "لا يوجد اتصال بالإنترنت");
        return;
      }
      await repo.deleteHoliday(id);
      holidays.removeWhere((element) => element.id == id);
      AppSnack.success("نجاح", "تم حذف العطلة");
    } catch (e) {
      AppSnack.error("خطأ", "فشل حذف العطلة");
    }
  }

  void showAddDialog() {
    nameController.clear();
    selectedDate.value = null;
    isRecurring.value = false;

    Get.defaultDialog(
      title: "إضافة عطلة جديدة",
      titleStyle: cairoStyle(fontSize: 17, fontweight: FontWeight.bold),
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            /// Holiday Name
            Textfieldapp(
              controller: nameController,
              hint: 'اسم الأجازة',
              suffixIcon: Icon(Icons.hotel_outlined),
            ),

            SizedBox(height: Get.height * 0.015),

            /// Recurring Switch
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("عطلة سنوية متكررة؟", style: cairoStyle(fontSize: 13)),
                  Switch(
                    value: isRecurring.value,
                    onChanged: (val) => isRecurring.value = val,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.015),

            /// Date Picker
            SizedBox(
              width: double.infinity,
              height: Get.height * 0.05,
              child: ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (picked != null) {
                    selectedDate.value = picked;
                  }
                },
                child: Obx(
                  () => Text(
                    selectedDate.value == null
                        ? "اختر التاريخ"
                        : "${selectedDate.value!.year}-${selectedDate.value!.month}-${selectedDate.value!.day}",
                    style: cairoStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// Confirm Button
      confirm: SizedBox(
        width: Get.width * 0.2,
        height: Get.height * 0.05,
        child: ElevatedButton(
          onPressed: () {
            if (nameController.text.isEmpty || selectedDate.value == null) {
              Get.snackbar("تنبيه", "يرجى إدخال الاسم والتاريخ");
              return;
            }

            final date = selectedDate.value!;
            final isRecurringValue = isRecurring.value;

            final holiday = HolidayModel(
              name: nameController.text,
              isRecurring: isRecurringValue,
              holidayDate: isRecurringValue ? null : date,
              day: isRecurringValue ? date.day : null,
              month: isRecurringValue ? date.month : null,
              year: isRecurringValue ? null : date.year,
            );

            addHoliday(holiday);
          },
          child: Text("حفظ", style: cairoStyle(fontSize: 12)),
        ),
      ),

      /// Cancel Button
      cancel: SizedBox(
        width: width * 0.2,
        height: Get.height * 0.05,
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text("إلغاء", style: cairoStyle(fontSize: 12)),
        ),
      ),
    );
  }
}
