import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/buildTextField.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/controller/PermissionController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/ListPermissionCards.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Permissions/widget/NoPermissionWidget.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PermissionView extends GetView<PermissionController> {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      if (controller.haserror.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchPermissions();
          },
        );
      }

      if (isDesktop) {
        return _desktopLayout(context);
      } else if (isTablet) {
        return _tabletLayout(context);
      } else {
        return _mobileLayout(context);
      }
    });
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _filterCard(context, useWrap: true),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Column(
          children: [
            _filterCard(context, useWrap: false),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _filterCard(
                    context,
                    useWrap: true,
                    showHeader: true,
                    isDesktopCard: true,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterCard(
    BuildContext context, {
    required bool useWrap,
    bool showHeader = false,
    bool isDesktopCard = false,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(isDesktopCard ? 0 : 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader) ...[
              Text(
                'فلترة الأذونات',
                style: cairoStyle(
                  fontSize: 18.spAdaptive(context),
                  fontweight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ابحث بالاسم وحدد الحالة أو الفترة الزمنية لعرض النتائج المناسبة.',
                textAlign: TextAlign.right,
                style: cairoStyle(
                  fontSize: 13.spAdaptive(context),
                  fontcolor: Colors.black54,
                ),
              ),
              const SizedBox(height: 18),
            ],
            buildTextField(
              onChanged: (val) => controller.searchQuery.value = val,
              controller: TextEditingController(),
              label: 'اسم الموظف',
              icon: Icons.search,
            ),
            const SizedBox(height: 12),
            useWrap
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: isDesktopCard
                            ? double.infinity
                            : 220.spAdaptive(context),
                        child: _statusDropdown(context),
                      ),
                      SizedBox(
                        width: isDesktopCard
                            ? double.infinity
                            : 90.spAdaptive(context),
                        child: _dateButton(context),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 2, child: _statusDropdown(context)),
                      const SizedBox(width: 10),
                      Expanded(child: _dateButton(context)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _statusDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedStatus.value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            items: ['الكل', 'مقبولة', 'مرفوضة', 'معلق'].map((String status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(
                  status,
                  style: cairoStyle(
                    fontSize: 14.spAdaptive(context),
                    fontcolor: Colors.black87,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                controller.selectedStatus.value = newValue;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _dateButton(BuildContext context) {
    return InkWell(
      onTap: _openDatePicker,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xff197fe6).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff197fe6).withOpacity(0.3)),
        ),
        child: Icon(
          Icons.calendar_month,
          color: const Color(0xff197fe6),
          size: 22.spAdaptive(context),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.permissions.isEmpty) {
        return const NoPermissionWidget();
      }

      return const ListPermissionCards();
    });
  }

  void _openDatePicker() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 400.h,
          width: 350.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            showActionButtons: true,
            confirmText: 'تأكيد',
            cancelText: 'إلغاء',
            onSubmit: (value) {
              if (value is PickerDateRange &&
                  value.startDate != null &&
                  value.endDate != null) {
                controller.setDateRange(
                  DateTimeRange(start: value.startDate!, end: value.endDate!),
                );
              }
              Get.back();
            },
            onCancel: () {
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
