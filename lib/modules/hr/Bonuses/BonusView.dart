import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/Bonuses/BonusController.dart';
import 'package:hrx/modules/hr/Bonuses/BonusRepo.dart';
import 'package:hrx/modules/hr/Bonuses/BonusServices.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class BonusScreen extends StatelessWidget {
  BonusScreen({super.key});

  final controller = Get.put(BonusController(BonusRepository(BonusService())));

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: 'سجل المكافأت'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          final bool isLoading = controller.isLoading.value;
          final displayList = controller.filteredPenalties;
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.fetchBonuses();
              },
            );
          }
          if ((isLoading && controller.bonuses.isEmpty) ||
              controller.networkController.isChecking.value) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolors.primarycolor),
            );
          }

          if (isDesktop) {
            return _desktopLayout(context, displayList);
          } else if (isTablet) {
            return _tabletLayout(context, displayList);
          } else {
            return _mobileLayout(context, displayList);
          }
        }),
      ),
    );
  }

  Widget _mobileLayout(BuildContext context, List displayList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildFilters(context, useWrap: true),
        ),
        Expanded(child: _buildBonusContent(context, displayList)),
      ],
    );
  }

  Widget _tabletLayout(BuildContext context, List displayList) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildFilters(context, useWrap: false),
            ),
            Expanded(child: _buildBonusContent(context, displayList)),
          ],
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context, List displayList) {
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
                child: _buildFilters(
                  context,
                  useWrap: true,
                  showHeader: true,
                  isDesktopCard: true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 6,
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
                  child: _buildBonusContent(context, displayList),
                ),
              ),
            ],
          ),
        ),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) ...[
            Text(
              'فلترة المكافأت',
              style: cairoStyle(
                fontSize: 18.spAdaptive(context),
                fontweight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ابحث باسم الموظف أو استخدم فلتر التاريخ للوصول إلى المكافأة المطلوبة بسرعة.',
              style: cairoStyle(
                fontSize: 13.spAdaptive(context),
                fontcolor: Colors.grey[700],
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
                      width: isDesktopCard ? double.infinity : 56,
                      child: _filterButton(context),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _searchField(context)),
                    const SizedBox(width: 10),
                    _filterButton(context),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: TextField(
        onChanged: (v) => controller.searchQuery.value = v,
        decoration: InputDecoration(
          hintText: 'بحث باسم الموظف...',
          hintStyle: cairoStyle(
            fontSize: 13.spAdaptive(context),
            fontcolor: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, size: 20.spAdaptive(context)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _filterButton(BuildContext context) {
    return IconButton.filled(
      onPressed: controller.showDateFilterDialog,
      icon: Icon(Icons.filter_list, size: 20.spAdaptive(context)),
      style: IconButton.styleFrom(
        backgroundColor: Appcolors.primarycolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildBonusContent(BuildContext context, List displayList) {
    if (displayList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard_rounded,
              size: 80.spAdaptive(context),
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد مكافأت مطابقة للبحث',
              style: cairoStyle(
                fontSize: 18.spAdaptive(context),
                fontcolor: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.fetchBonuses,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: displayList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final bonus = displayList[index];
          final employee = bonus.employee;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.isDesktop(context) ? 920 : 820,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 420;

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.grey[200]!),
                                image:
                                    employee?.imageUrl != null &&
                                        employee!.imageUrl!.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(employee.imageUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child:
                                  employee?.imageUrl == null ||
                                      employee!.imageUrl!.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      color: Appcolors.primarycolor,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employee?.name ?? 'غير معروف',
                                    style: cairoStyle(
                                      fontSize: 14.spAdaptive(context),
                                      fontweight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  if (bonus.reason.isNotEmpty)
                                    Text(
                                      bonus.reason,
                                      style: cairoStyle(
                                        fontSize: 12.spAdaptive(context),
                                        fontcolor: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 14.spAdaptive(context),
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        TimeHelper.formatDateToArabic(
                                          bonus.bonusDate,
                                        ),
                                        style: cairoStyle(
                                          fontSize: 11.spAdaptive(context),
                                          fontcolor: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!isCompact) ...[
                              const SizedBox(width: 12),
                              _buildAmountBox(context, bonus),
                            ],
                          ],
                        ),
                        if (isCompact) ...[
                          const SizedBox(height: 12),
                          Row(children: [_buildAmountBox(context, bonus)]),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAmountBox(BuildContext context, dynamic bonus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Appcolors.primarycolor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            bonus.isPercentage
                ? '%${bonus.amount.toStringAsFixed(0)}'
                : bonus.amount.toStringAsFixed(0),
            style: cairoStyle(
              fontSize: 16.spAdaptive(context),
              fontweight: FontWeight.bold,
              fontcolor: Appcolors.primarycolor,
            ),
          ),
          if (!bonus.isPercentage)
            Text(
              'جنيه',
              style: cairoStyle(
                fontSize: 10.spAdaptive(context),
                fontcolor: Appcolors.primarycolor,
              ),
            ),
        ],
      ),
    );
  }
}
