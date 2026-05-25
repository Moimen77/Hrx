import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/Loans/controller/LoanController.dart';
import 'package:hrx/modules/hr/Loans/widget/LoanCard.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class AdvanceArchiveView extends GetView<AdvanceArchiveController> {
  const AdvanceArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: isDesktop
          ? _desktopLayout(context)
          : isTablet
          ? _tabletLayout(context)
          : _mobileLayout(context),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _filterCard(context, useWrap: true),
          const SizedBox(height: 12),
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _filterCard(context, useWrap: false),
              const SizedBox(height: 16),
              Expanded(child: _buildContent(context)),
            ],
          ),
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
                  child: _buildContent(context),
                ),
              ),
            ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) ...[
            Text(
              'فلترة السلف',
              style: cairoStyle(
                fontSize: 18.spAdaptive(context),
                fontweight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ابحث باسم الموظف وحدد الحالة أو التاريخ للوصول إلى الطلبات بسرعة.',
              style: cairoStyle(
                fontSize: 13.spAdaptive(context),
                fontcolor: Colors.black54,
              ),
            ),
            const SizedBox(height: 18),
          ],
          _searchField(context),
          const SizedBox(height: 10),
          useWrap
              ? Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: isDesktopCard ? double.infinity : 220,
                      child: _statusDropdown(context),
                    ),
                    SizedBox(
                      width: isDesktopCard ? double.infinity : 90,
                      child: _dateButton(context),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 2, child: _statusDropdown(context)),
                    const SizedBox(width: 8),
                    Expanded(child: _dateButton(context)),
                  ],
                ),
        ],
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

  Widget _statusDropdown(BuildContext context) {
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
            value: controller.selectedStatus.value,
            isExpanded: true,
            style: cairoStyle(fontSize: 12.spAdaptive(context)),
            onChanged: (v) => controller.selectedStatus.value = v!,
            items: [
              'الكل',
              'معلقة',
              'مقبولة',
              'مرفوضة',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          ),
        ),
      ),
    );
  }

  Widget _dateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IconButton.filled(
        onPressed: controller.showDateFilterDialog,
        icon: Icon(Icons.calendar_today_outlined, size: 20.spAdaptive(context)),
        style: IconButton.styleFrom(
          backgroundColor: Appcolors.primarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.advances.isEmpty) {
        return Loadingcircular();
      }

      if (!controller.networkController.isConnected.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchUserAdvances();
          },
        );
      }
      final displayList = controller.filteredAdvances;
      if (displayList.isEmpty) {
        return Center(
          child: Text(
            'لا توجد سلف مطابقة للبحث',
            style: cairoStyle(
              fontcolor: Colors.grey,
              fontSize: 14.spAdaptive(context),
            ),
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUserAdvances();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: displayList.length,
          itemBuilder: (context, index) => Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.isDesktop(context) ? 920 : 820,
              ),
              child: AdvanceCard(advance: displayList[index]),
            ),
          ),
        ),
      );
    });
  }
}
