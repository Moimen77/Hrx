import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/TimeHelper.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesController.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class PenaltyScreen extends GetView<PenaltyController> {
  const PenaltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: 'سجل الجزائات والخصومات'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          final bool isLoading = controller.isLoading.value;
          final displayList = controller.filteredPenalties;
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.fetchPenalties();
              },
            );
          }
          if ((isLoading && controller.penalties.isEmpty) ||
              controller.networkController.isChecking.value) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolors.primarycolor),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (v) => controller.searchQuery.value = v,
                          decoration: InputDecoration(
                            hintText: 'بحث باسم الموظف...',
                            hintStyle: cairoStyle(
                              fontSize: 13,
                              fontcolor: Colors.grey,
                            ),
                            prefixIcon: const Icon(Icons.search, size: 20),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filled(
                      onPressed: controller.showDateFilterDialog,
                      icon: const Icon(Icons.filter_list),
                      style: IconButton.styleFrom(
                        backgroundColor: Appcolors.primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (displayList.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.gavel_rounded,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا يوجد جزائات مطابقة للبحث',
                          style: cairoStyle(
                            fontSize: 18,
                            fontcolor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      itemCount: displayList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final penalty = displayList[index];
                        final employee = penalty.employee;

                        return Container(
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
                          child: Row(
                            children: [
                              // صورة الموظف
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
                                          image: NetworkImage(
                                            employee.imageUrl!,
                                          ),
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

                              // تفاصيل الجزاء
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee?.name ?? 'غير معروف',
                                      style: cairoStyle(
                                        fontSize: 14,
                                        fontweight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    if (penalty.reason.isNotEmpty)
                                      Text(
                                        penalty.reason,
                                        style: cairoStyle(
                                          fontSize: 12,
                                          fontcolor: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          TimeHelper.formatDateToArabic(
                                            penalty.penaltyDate,
                                          ),
                                          style: cairoStyle(
                                            fontSize: 11,
                                            fontcolor: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          penalty.amountDay.toStringAsFixed(1),
                                          style: cairoStyle(
                                            fontSize: 16,
                                            fontweight: FontWeight.bold,
                                            fontcolor: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          penalty.isRival ? 'جنيه' : 'يوم',
                                          style: cairoStyle(
                                            fontSize: 10,
                                            fontcolor: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (penalty.status == 'active')
                                        GestureDetector(
                                          onTap: () => controller
                                              .showEditDialog(penalty),
                                          child: const Icon(
                                            Icons.edit_note,
                                            color: Appcolors.primarycolor,
                                            size: 22,
                                          ),
                                        ),
                                      const SizedBox(width: 12),
                                      if (penalty.status == 'active')
                                        GestureDetector(
                                          onTap: () =>
                                              controller.cancelPenalty(penalty),
                                          child: const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
