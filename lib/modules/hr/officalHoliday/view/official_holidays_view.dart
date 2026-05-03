import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/officalHoliday/view/official_holidays_controller.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';

class OfficialHolidaysView extends GetView<OfficialHolidaysController> {
  const OfficialHolidaysView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      if (controller.isLoading.value ||
          controller.networkController.isChecking.value) {
        return Loadingcircular();
      }

      if (!controller.networkController.isConnected.value) {
        return NoInternetWidget(
          onPressed: () async {
            await controller.fetchHolidays();
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
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          _buildTopBar(context),
          const SizedBox(height: 14),
          Expanded(child: _buildHolidayList(context)),
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
              _buildTopBar(context),
              const SizedBox(height: 16),
              Expanded(child: _buildHolidayList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildTopBar(context, showDescription: true),
              const SizedBox(height: 18),
              Expanded(child: _buildHolidayList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, {bool showDescription = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "العطلات الرسمية",
                  style: cairoStyle(
                    fontSize: 18.spAdaptive(context),
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: controller.showAddDialog,
                icon: Icon(Icons.add, size: 18.spAdaptive(context)),
                label: Text(
                  "إضافة عطلة",
                  style: cairoStyle(
                    fontSize: 12.spAdaptive(context),
                    fontcolor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          if (showDescription) ...[
            const SizedBox(height: 8),
            Text(
              "يمكنك إضافة العطلات الرسمية السنوية أو المؤقتة وحذف أي عنصر عند الحاجة.",
              style: cairoStyle(
                fontSize: 13.spAdaptive(context),
                fontcolor: Colors.grey.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHolidayList(BuildContext context) {
    if (controller.holidays.isEmpty) {
      return Center(
        child: Text(
          "لا توجد عطلات مسجلة",
          style: cairoStyle(
            fontSize: 18.spAdaptive(context),
            fontweight: FontWeight.w600,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.holidays.length,
      itemBuilder: (context, index) {
        final holiday = controller.holidays[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(.05),
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 420;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.celebration,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              holiday.name,
                              style: cairoStyle(
                                fontSize: 16.spAdaptive(context),
                                fontweight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              holiday.isRecurring
                                  ? "كل سنة في ${holiday.day}/${holiday.month}"
                                  : "التاريخ: ${holiday.holidayDate.toString().split(' ')[0]}",
                              style: cairoStyle(
                                fontSize: 13.spAdaptive(context),
                                fontcolor: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (isCompact)
                    Row(
                      children: [
                        _buildTypeBadge(context, holiday.isRecurring),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => controller.showDeleteDialog(holiday),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        _buildTypeBadge(context, holiday.isRecurring),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => controller.showDeleteDialog(holiday),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTypeBadge(BuildContext context, bool isRecurring) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isRecurring
            ? Colors.green.withOpacity(.15)
            : Colors.orange.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isRecurring ? "سنوية" : "مرة واحدة",
        style: cairoStyle(
          fontSize: 12.spAdaptive(context),
          fontweight: FontWeight.w600,
          fontcolor: isRecurring ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
