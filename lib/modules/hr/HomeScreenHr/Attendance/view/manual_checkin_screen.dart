import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/controller/checkinController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/DropDownEmployyees.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/EmployeeCard.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/NotesTextField.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/SelectTimeWidget.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Attendance/widget/Manualcheckin/sectionTitle.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ManualAttendanceScreen extends GetView<ManualAttendanceController> {
  final Attendancemode mode;

  const ManualAttendanceScreen({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: CustomAppBar(
          title: mode == Attendancemode.checkIn
              ? "تسجيل حضور يدوي"
              : "تسجيل انصراف يدوي",
        ),
        body: Obx(() {
          if (controller.haserror.value) {
            return NoInternetWidget(onPressed: controller.fetchEmployees);
          }

          if (isDesktop) {
            return _desktopLayout();
          } else if (isTablet) {
            return _tabletLayout();
          } else {
            return _mobileLayout();
          }
        }),
      ),
    );
  }

  // ================= MOBILE =================
  Widget _mobileLayout() {
    return _formContent(isWide: false);
  }

  // ================= TABLET =================
  Widget _tabletLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: _formContent(isWide: false),
    );
  }

  // ================= DESKTOP =================
  Widget _desktopLayout() {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1100.w),
        child: Row(
          children: [
            /// الفورم
            Expanded(flex: 2, child: _formContent(isWide: true)),

            SizedBox(width: 30.w),

            /// Preview / Employee Card
            Expanded(
              child: Obx(() {
                if (controller.selectedEmployeeData == null) {
                  return Center(
                    child: Text(
                      "اختر موظف لعرض البيانات",
                      style: cairoStyle(fontSize: 14.sp),
                    ),
                  );
                }

                return Employeecard(emp: controller.selectedEmployeeData!);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ================= FORM =================
  Widget _formContent({required bool isWide}) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Employee
          Sectiontitle(title: "اختيار الموظف"),
          Dropdownemployyees(),

          SizedBox(height: 15.h),

          /// Date
          Sectiontitle(title: "التاريخ"),
          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () {
              Get.dialog(
                Dialog(
                  child: SizedBox(
                    height: 350.h,
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedDate: controller.selectedDate.value,
                      onSelectionChanged: (args) {
                        if (args.value is DateTime) {
                          controller.selectedDate.value = args.value;
                          Get.back();
                        }
                      },
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Obx(
                () => Text(
                  "${controller.selectedDate.value.year}-${controller.selectedDate.value.month}-${controller.selectedDate.value.day}",
                  style: cairoStyle(
                    fontSize: 14.spAdaptive(Get.context!),
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 15.h),

          /// Time
          Sectiontitle(
            title: mode == Attendancemode.checkIn
                ? "وقت الحضور"
                : "وقت الانصراف",
          ),

          Selecttimewidget(false),

          SizedBox(height: 15.h),

          /// Delay
          if (mode == Attendancemode.checkIn) ...[
            Sectiontitle(title: "تفاصيل التأخير"),
            SizedBox(height: 10.h),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _delayItem("لا يوجد"),
                _delayItem("ربع يوم"),
                _delayItem("نصف يوم"),
                _delayItem("يوم كامل"),
              ],
            ),

            SizedBox(height: 10.h),

            Obx(
              () => CheckboxListTile(
                title: Text(
                  "هل يوجد إذن ؟",
                  style: cairoStyle(fontSize: 14.spAdaptive(Get.context!)),
                ),
                value: controller.hasPermission.value,
                onChanged: (val) =>
                    controller.hasPermission.value = val ?? false,
                checkboxScaleFactor: 1.2.spAdaptive(Get.context!),
              ),
            ),
          ],

          SizedBox(height: 15.h),

          /// Notes
          Sectiontitle(title: "ملاحظات"),
          Notestextfield(controller: controller.notesController),

          SizedBox(height: 30.h),

          /// Button
          Buttonapp(
            isloading: controller.isCheckinLoading.value,
            OnTap: () => controller.submit(mode, Get.context!),
            width: double.infinity,
            text: mode == Attendancemode.checkIn
                ? 'تأكيد الحضور'
                : 'تأكيد الانصراف',
            Loadingtext: 'جاري التنفيذ...',
          ),
        ],
      ),
    );
  }

  // ================= Delay Item =================
  Widget _delayItem(String title) {
    return Obx(() {
      final isSelected = controller.selectedDelay.value == title;

      return GestureDetector(
        onTap: () => controller.selectedDelay.value = title,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff197fe6) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? const Color(0xff197fe6)
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            title,
            style: cairoStyle(
              fontSize: 12.sp,
              fontcolor: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    });
  }
}
