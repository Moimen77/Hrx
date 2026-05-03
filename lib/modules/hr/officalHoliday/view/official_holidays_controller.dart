import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
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

    final context = Get.context!;
    final isDesktop = Responsive.isDesktop(context);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 520 : 360),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "إضافة عطلة جديدة",
                      style: cairoStyle(
                        fontSize: 17.spAdaptive(context),
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Textfieldapp(
                    controller: nameController,
                    hint: 'اسم الأجازة',
                    suffixIcon: const Icon(Icons.hotel_outlined),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "عطلة سنوية متكررة؟",
                        style: cairoStyle(fontSize: 13.spAdaptive(context)),
                      ),
                      Switch(
                        value: isRecurring.value,
                        onChanged: (val) => isRecurring.value = val,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (picked != null) {
                          selectedDate.value = picked;
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                      label: Text(
                        selectedDate.value == null
                            ? "اختر التاريخ"
                            : "${selectedDate.value!.year}-${selectedDate.value!.month}-${selectedDate.value!.day}",
                        style: cairoStyle(fontSize: 12.spAdaptive(context)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "إلغاء",
                            style: cairoStyle(fontSize: 12.spAdaptive(context)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty ||
                                selectedDate.value == null) {
                              Get.snackbar(
                                "تنبيه",
                                "يرجى إدخال الاسم والتاريخ",
                              );
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
                          child: Text(
                            "حفظ",
                            style: cairoStyle(fontSize: 12.spAdaptive(context)),
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

  void showDeleteDialog(HolidayModel holiday) {
    final context = Get.context!;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "حذف العطلة",
                style: cairoStyle(
                  fontSize: 16.spAdaptive(context),
                  fontweight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "هل تريد حذف عطلة ${holiday.name}؟",
                textAlign: TextAlign.center,
                style: cairoStyle(
                  fontSize: 13.spAdaptive(context),
                  fontcolor: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "إلغاء",
                        style: cairoStyle(fontSize: 12.spAdaptive(context)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Get.back();
                        deleteHoliday(holiday.id!);
                      },
                      child: Text(
                        "حذف",
                        style: cairoStyle(
                          fontSize: 12.spAdaptive(context),
                          fontcolor: Colors.white,
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
    );
  }
}
