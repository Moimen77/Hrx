import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/DropDeownLeaveType.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/DropDownEmployee.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/DropDownLeaveSubType.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/DropDownPenalty.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/FilterPeriod.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/LeaveReason.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/widget/AddLeave/SubmitleaveButton.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddLeaveScreen extends GetView<AddLeaveController> {
  const AddLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddLeaveController());
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'طلب إجازة جديد'),
      body: isDesktop
          ? _desktopLayout()
          : isTablet
              ? _tabletLayout()
              : _mobileLayout(),
    );
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _formShell(child: _buildFormContent()),
    );
  }

  Widget _tabletLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: _formShell(child: _buildFormContent()),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _formShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تسجيل طلب إجازة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(8),
                        const Text(
                          'اختر الموظف ونوع الإجازة وحدد الفترة والسبب قبل الإرسال.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black54,
                            height: 1.7,
                          ),
                        ),
                        const Gap(24),
                        _buildFormContent(),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F9FD),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xffE2E8F0)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ملاحظات سريعة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(12),
                        Text(
                          'حقول نوع الإجازة الفرعي والجزاء تظهر تلقائياً حسب النوع الذي تختاره.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black87,
                            height: 1.7,
                          ),
                        ),
                        Gap(10),
                        Text(
                          'يمكنك إدخال تاريخ البداية والنهاية من نفس الشاشة بدون تنقل إضافي.',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black87,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formShell({required Widget child}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: child,
      ),
    );
  }

  Widget _buildFormContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownEmployee(),
        Gap(20),
        DropDeownLeaveType(),
        Gap(20),
        DropDownLeaveSubType(),
        DropDownPenalty(),
        Filterperiod(),
        Gap(20),
        LeaveReason(),
        Gap(30),
        SubmitLeaveButton(),
      ],
    );
  }
}
