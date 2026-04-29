import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/controller/ShiftController.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';

void showEditShiftDialog({
  required BuildContext context,
  required ShiftModel shift,
  required ShiftController controller,
}) {
  final nameController = TextEditingController(text: shift.name);
  final startController = TextEditingController(text: shift.startTime);
  final endController = TextEditingController(text: shift.endTime);

  Future<void> pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      controller.text = TimeHelper.formatToArabicTime(dt);
    }
  }

  Get.defaultDialog(
    title: "تعديل الشيفت",
    titleStyle: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
    content: Column(
      children: [
        // 🟢 الاسم
        Textfieldapp(
          controller: nameController,
          hint: "الاسم",
          suffixIcon: Icon(Icons.edit, size: 20),
        ),
        SizedBox(height: 10),
        // 🟢 وقت البداية
        Textfieldapp(
          controller: startController,
          onTap: () => pickTime(startController),
          hint: 'بداية الشيفت',
          suffixIcon: Icon(Icons.access_time),
        ),

        SizedBox(height: 10),

        // 🟢 وقت النهاية
        Textfieldapp(
          controller: endController,
          suffixIcon: Icon(Icons.access_time),
          hint: 'نهاية الشيفت',
          onTap: () => pickTime(endController),
        ),
      ],
    ),
    textConfirm: "حفظ",
    textCancel: "إلغاء",
    onConfirm: () {
      if (nameController.text.isEmpty ||
          startController.text.isEmpty ||
          endController.text.isEmpty) {
        AppSnack.error("خطأ", "من فضلك ضع كل البيانات");
        return;
      }

      controller.updateShift(
        shiftId: shift.id,
        name: nameController.text,
        startTime: TimeHelper.arabicTimeTo24(startController.text),
        endTime: TimeHelper.arabicTimeTo24(endController.text),
      );
      Get.back();
    },
  );
}
