import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/checkinController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/DropDownEmployyees.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/EmployeeCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/NotesTextField.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/SelectTimeWidget.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/sectionTitle.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Checkininfodata extends GetView<ManualAttendanceController> {
  const Checkininfodata(this.isSmall, this.mode, {super.key});
  final bool isSmall;
  final Attendancemode mode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 14 : 20,
        vertical: 20,
      ),
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Sectiontitle(title: "اختيار الموظف"),
                  Dropdownemployyees(),

                  const SizedBox(height: 15),
                  if (controller.selectedEmployeeData != null)
                    Employeecard(emp: controller.selectedEmployeeData!),
                  const SizedBox(height: 15),
                  Sectiontitle(title: "التاريخ"),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            height: 350,
                            width: 350,
                            padding: const EdgeInsets.all(10),
                            child: SfDateRangePicker(
                              headerHeight: 50,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              showNavigationArrow: true,
                              initialSelectedDate:
                                  controller.selectedDate.value,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                    if (args.value is DateTime) {
                                      controller.selectedDate.value =
                                          args.value;
                                      Get.back();
                                    }
                                  },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              "${controller.selectedDate.value.year}-${controller.selectedDate.value.month}-${controller.selectedDate.value.day}",
                              style: cairoStyle(
                                fontSize: 14,
                                fontweight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff197fe6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Sectiontitle(
                    title: mode == Attendancemode.checkIn
                        ? "وقت الحضور"
                        : 'وقت الأنصراف',
                  ),

                  Selecttimewidget(isSmall),

                  const SizedBox(height: 15),

                  if (mode == Attendancemode.checkIn) ...[
                    Sectiontitle(title: "تفاصيل التأخير"),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildDelayOption("لا يوجد")),
                        const SizedBox(width: 5),
                        Expanded(child: _buildDelayOption("ربع يوم")),
                        const SizedBox(width: 5),
                        Expanded(child: _buildDelayOption("نصف يوم")),
                        const SizedBox(width: 5),
                        Expanded(child: _buildDelayOption("يوم كامل")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "هل يوجد إذن ؟",
                        style: cairoStyle(fontweight: FontWeight.bold),
                      ),
                      value: controller.hasPermission.value,
                      onChanged: (val) =>
                          controller.hasPermission.value = val ?? false,
                    ),
                    const SizedBox(height: 15),
                  ],

                  Sectiontitle(title: "ملاحظات"),

                  Notestextfield(controller: controller.notesController),
                  const SizedBox(height: 35),

                  Buttonapp(
                    isloading: controller.isCheckinLoading.value,
                    OnTap: () => controller.submit(mode, context),
                    width: Get.width * 0.8,
                    text: mode == Attendancemode.checkIn
                        ? 'تأكيد الحضور'
                        : 'تأكيد الأنصراف',
                    Loadingtext: mode == Attendancemode.checkIn
                        ? 'جاري تسجيل الحضور'
                        : 'جاري تسجيل الأنصراف',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDelayOption(String title) {
    final isSelected = controller.selectedDelay.value == title;
    return GestureDetector(
      onTap: () => controller.selectedDelay.value = title,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff197fe6) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xff197fe6) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: cairoStyle(
            fontSize: 12,
            fontcolor: isSelected ? Colors.white : Colors.black,
            fontweight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
