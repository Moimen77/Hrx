// ignore_for_file: body_might_complete_normally_nullable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/controller/SalaryController.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/RowSalarySummary.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/ShiftModalSheet.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/ShowSalaryDetails.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/TitleSalaryCard.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/addCasesDialog.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class SalaryScreen extends GetView<SalaryController> {
  const SalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    if (isDesktop) {
      return _desktopLayout(context);
    } else if (isTablet) {
      return _tabletLayout(context);
    } else {
      return _mobileLayout(context);
    }
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildFilters(context, useWrap: true),
        ),
        Expanded(child: _buildContent(context)),
      ],
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildFilters(context, useWrap: false),
            ),
            Expanded(child: _buildContent(context)),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildHeader(context, isDesktopCard: true),
                    const SizedBox(height: 16),
                    _buildFilters(
                      context,
                      useWrap: true,
                      showHeader: true,
                      isDesktopCard: true,
                    ),
                  ],
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
                  child: _buildContent(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalaryCard(BuildContext context, SalaryResultModel salary) {
    final isPaid = salary.isPaid;

    return Container(
      padding: EdgeInsets.all(16.spAdaptive(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          /// زرار الثلاث نقاط فوق
          Positioned(
            top: 22,
            right: 0,
            child: _buildActionsMenu(context, salary),
          ),

          /// المحتوى الأساسي
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSalaryCard(salary: salary),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: _buildStatusBadge(context, isPaid),
              ),
              const SizedBox(height: 6),
              Text(
                "الرقم الوظيفي: ${salary.employeeId}",
                style: cairoStyle(
                  fontSize: 12.spAdaptive(context),
                  fontcolor: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 14),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 10),

              /// ملخص الراتب
              RowSalarySummary(salary: salary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool isPaid) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.spAdaptive(context),
        vertical: 4.spAdaptive(context),
      ),
      decoration: BoxDecoration(
        color: isPaid ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isPaid ? "مدفوع" : "قيد المراجعة",
        style: cairoStyle(
          fontSize: 11.spAdaptive(context),
          fontweight: FontWeight.w600,
          fontcolor: isPaid ? Colors.green : Colors.orange,
        ),
      ),
    );
  }

  Widget _buildActionsMenu(BuildContext context, SalaryResultModel salary) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.more_vert_rounded,
          size: 20,
          color: Colors.blueGrey,
        ),
      ),
      onSelected: (String value) {
        switch (value) {
          case 'details':
            salary.salaryDetails is SalaryDetails
                ? showDetails(context, salary)
                : showShiftSalaryDetails(
                    context,
                    salary.salaryDetails as ShiftSalaryDetails,
                    salary,
                  );
            break;
          case 'allowance':
            _showAddAllowanceDialog(context, salary);
            break;
          case 'hr_score':
            _showHrScoreDialog(context, salary);
            break;
          case 'pay':
            _confirmPaySalary(context, salary);
            break;
          case 'edit_absence':
            _showEditAbsenceDialog(context, salary);
            break;
          case 'add_cases':
            showShiftCasesDialog(
              context: context,
              employeeId: salary.employeeId,
              controller: controller,
            );

            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildMenuItem(
          value: 'details',
          icon: Icons.receipt_long_outlined,
          text: 'عرض التفاصيل',
        ),
        if (!salary.isPaid) const PopupMenuDivider(height: 8),
        if (!salary.isPaid && salary.salarytype != 'shifts')
          _buildMenuItem(
            value: 'allowance',
            icon: Icons.add_card_outlined,
            text: 'إضافة بدلات',
          ),
        if (!salary.isPaid)
          _buildMenuItem(
            value: 'hr_score',
            icon: Icons.star_outline,
            text: 'تقييم HR',
          ),
        if (!salary.isPaid)
          _buildMenuItem(
            value: 'pay',
            icon: Icons.check_circle_outline,
            text: 'تسليم الراتب',
            iconColor: Colors.green,
            textColor: Colors.green,
          ),
        if (!salary.isPaid && salary.salarytype == 'shifts')
          _buildMenuItem(
            value: 'add_cases',
            icon: Icons.add_circle_outline,
            text: 'اضافة حالات الشيفتات',
          ),
        if (!salary.isPaid && salary.salarytype != 'shifts' && salary.ishalf!)
          _buildMenuItem(
            value: 'edit_absence',
            icon: Icons.edit_calendar,
            text: 'تعديل الغياب',
          ),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem({
    required String value,
    required IconData icon,
    required String text,
    Color? iconColor,
    Color? textColor,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 42,
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor ?? Colors.blueGrey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: cairoStyle(
                fontSize: 14.spAdaptive(Get.context!),
                fontweight: FontWeight.w500,
                fontcolor: textColor ?? Colors.blueGrey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(
    BuildContext context, {
    required bool useWrap,
    bool showHeader = false,
    bool isDesktopCard = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
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
                'فلترة الرواتب',
                style: cairoStyle(
                  fontSize: 18.spAdaptive(context),
                  fontweight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ابحث باسم الموظف أو اختر نوع الراتب للوصول إلى السجل المطلوب بسرعة.',
                style: cairoStyle(
                  fontSize: 13.spAdaptive(context),
                  fontcolor: Colors.black54,
                ),
              ),
              const SizedBox(height: 18),
            ],
            useWrap
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: isDesktopCard ? double.infinity : 220,
                        child: _searchField(context),
                      ),
                      SizedBox(
                        width: isDesktopCard ? double.infinity : 170,
                        child: _salaryTypeDropdown(context),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _searchField(context)),
                      const SizedBox(width: 8),
                      Expanded(child: _salaryTypeDropdown(context)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        onChanged: (v) => controller.searchQuery.value = v,
        decoration: InputDecoration(
          hintText: 'بحث باسم الموظف...',
          hintStyle: cairoStyle(
            fontSize: 12.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, size: 20.spAdaptive(context)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _salaryTypeDropdown(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedSalaryType.value,
            isExpanded: true,
            style: cairoStyle(fontSize: 12.spAdaptive(context)),
            onChanged: (v) => controller.selectedSalaryType.value = v!,
            items: controller.salaryTypeLabels.entries
                .map(
                  (entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value ||
          controller.networkController.isChecking.value) {
        return Center(child: Loadingcircular());
      }
      final displayList = controller.filteredSalaries;
      if (displayList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payments_outlined,
                size: 60.spAdaptive(context),
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              Text(
                "لا توجد بيانات رواتب مطابقة للبحث",
                style: cairoStyle(
                  fontSize: 14.spAdaptive(context),
                  fontcolor: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchAllSalaries();
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: displayList.length,
          separatorBuilder: (c, i) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final SalaryResultModel salary = displayList[index];
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.isDesktop(context) ? 920 : 820,
                ),
                child: _buildSalaryCard(context, salary),
              ),
            );
          },
        ),
      );
    });
  }

  void _confirmPaySalary(BuildContext context, SalaryResultModel salary) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// أيقونة
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.payments_rounded,
                  size: 32,
                  color: Colors.green.shade600,
                ),
              ),

              const SizedBox(height: 16),

              /// العنوان
              Text(
                "تأكيد تسليم الراتب",
                style: cairoStyle(fontSize: 17, fontweight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              /// الرسالة
              Text(
                "هل أنت متأكد من تسليم راتب\n${salary.name} ؟\n\nبعد التأكيد لن يمكن تعديل البيانات.",
                style: cairoStyle(
                  fontSize: 13,
                  fontcolor: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "إلغاء",
                        style: cairoStyle(fontcolor: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        controller.paySalary(salary);
                        Get.back();
                      },
                      child: Text(
                        "تأكيد",
                        style: cairoStyle(fontcolor: Colors.white),
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

  void _showAddAllowanceDialog(BuildContext context, SalaryResultModel salary) {
    controller.initAllowanceFields();

    Get.defaultDialog(
      title: "إضافة بدلات",
      titleStyle: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      radius: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      content: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "الموظف: ${salary.name}",
                    style: cairoStyle(
                      fontSize: 13,
                      fontweight: FontWeight.w600,
                      fontcolor: Colors.grey.shade700,
                    ),
                  ),
                ),
                ...controller.allowanceFields.asMap().entries.map((entry) {
                  int index = entry.key;
                  var controllers = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: controllers.nameController,
                            style: cairoStyle(fontSize: 13),
                            decoration: InputDecoration(
                              labelText: "وصف البدل",
                              labelStyle: cairoStyle(fontSize: 12),
                              prefixIcon: const Icon(
                                Icons.edit_note,
                                size: 18,
                                color: Colors.blueGrey,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: controllers.amountController,
                            style: cairoStyle(fontSize: 13),
                            decoration: InputDecoration(
                              labelText: "المبلغ",
                              labelStyle: cairoStyle(fontSize: 12),
                              prefixIcon: const Icon(
                                Icons.attach_money,
                                size: 18,
                                color: Colors.green,
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        if (controller.allowanceFields.length > 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0, top: 4),
                            child: InkWell(
                              onTap: () =>
                                  controller.removeAllowanceField(index),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade400,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.blue.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 18,
                      color: Colors.blue.shade700,
                    ),
                    label: Text(
                      "إضافة بند آخر",
                      style: cairoStyle(
                        fontSize: 13,
                        fontcolor: Colors.blue.shade700,
                      ),
                    ),
                    onPressed: () => controller.addAllowanceField(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        controller.clearAllowanceFields();
        return true;
      },
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.save, size: 18, color: Colors.white),
        label: Text("حفظ", style: cairoStyle(fontcolor: Colors.white)),
        onPressed: () {
          controller.saveAllowances(salary);
          Get.back();
        },
      ),
      cancel: TextButton(
        onPressed: () {
          controller.clearAllowanceFields();
          Get.back();
        },
        child: const Text("إلغاء"),
      ),
    );
  }

  void _showHrScoreDialog(BuildContext context, SalaryResultModel salary) {
    Get.defaultDialog(
      title: "تقييم HR",
      titleStyle: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
      radius: 12,
      content: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade50,
                child: const Icon(
                  Icons.assignment_ind,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                salary.name,
                style: cairoStyle(fontSize: 13, fontweight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "${controller.hrScore.value}",
                style: cairoStyle(
                  fontSize: 24,
                  fontweight: FontWeight.bold,
                  fontcolor: controller.hrScore.value >= 75
                      ? Colors.green
                      : controller.hrScore.value >= 50
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                ),
                child: Slider(
                  value: controller.hrScore.value.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  onChanged: (value) {
                    controller.setHrScore(value.toInt());
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                    onPressed: controller.hrScore.value > 0
                        ? () => controller.decrementHrScore()
                        : null,
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                    onPressed: controller.hrScore.value < 100
                        ? () => controller.incrementHrScore()
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.save, size: 18, color: Colors.white),
        label: Text("حفظ", style: cairoStyle(fontcolor: Colors.white)),
        onPressed: () {
          controller.updateHrScore(salary.employeeId, controller.hrScore.value);
          Get.back();
        },
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text("إلغاء"),
      ),
    );
  }

  void _showEditAbsenceDialog(BuildContext context, SalaryResultModel salary) {
    TextEditingController absenceController = TextEditingController(
      text: (salary.salaryDetails as SalaryDetails).absenceDays.toString(),
    );

    Get.defaultDialog(
      title: "تعديل أيام الغياب",
      titleStyle: cairoStyle(fontSize: 18, fontweight: FontWeight.bold),
      radius: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // اسم الموظف
          Text(
            salary.name,
            style: cairoStyle(fontSize: 16, fontweight: FontWeight.w600),
          ),

          const SizedBox(height: 15),

          // حقل إدخال أيام الغياب
          TextField(
            controller: absenceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "عدد أيام الغياب",
              labelStyle: cairoStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // أزرار حفظ وإلغاء
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // زر إلغاء
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                  child: Text(
                    "إلغاء",
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.w500,
                      fontcolor: Colors.grey[700]!,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              // زر حفظ
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    int newAbsence = int.tryParse(absenceController.text) ?? 0;
                    controller.recalcSalaryAfterAbsence(salary, newAbsence);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "حفظ",
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, {bool isDesktopCard = false}) {
    return Container(
      margin: EdgeInsets.only(top: isDesktopCard ? 0 : 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: Colors.blue,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
              () => Text(
                "رواتب شهر ${controller.selectedDate.value.month} / ${controller.selectedDate.value.year}",
                style: cairoStyle(
                  fontSize: 15.spAdaptive(context),
                  fontweight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: controller.updateDate,
            icon: Icon(
              Icons.edit_calendar_rounded,
              size: 20.spAdaptive(context),
            ),
          ),
        ],
      ),
    );
  }
}
