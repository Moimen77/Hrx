import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/BonusModel.dart';
import 'package:hrx/modules/hr/Bonuses/BonusRepo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BonusController extends GetxController {
  final BonusRepository repo;

  BonusController(this.repo);

  var bonuses = <BonusModel>[].obs;
  var isLoading = false.obs;
  final networkController = Get.find<NetworkController>();

  var searchQuery = ''.obs;
  var dateRange = Rx<PickerDateRange?>(null);

  @override
  void onInit() {
    fetchBonuses();
    super.onInit();
  }

  List<BonusModel> get filteredPenalties {
    return bonuses.where((bonus) {
      final nameMatch =
          searchQuery.value.isEmpty ||
          (bonus.employee?.name?.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ??
              false);

      bool dateMatch = true;
      if (dateRange.value != null && dateRange.value!.startDate != null) {
        final start = dateRange.value!.startDate!;
        final end = dateRange.value!.endDate ?? start;
        dateMatch =
            bonus.bonusDate.isAfter(
              start.subtract(const Duration(seconds: 1)),
            ) &&
            bonus.bonusDate.isBefore(end.add(const Duration(days: 1)));
      }

      return nameMatch && dateMatch;
    }).toList();
  }

  Future<void> fetchBonuses() async {
    try {
      isLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      bonuses.value = await repo.fetchBonuses();
    } catch (e) {
      AppSnack.error('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showDateFilterDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                onSelectionChanged: (args) {
                  if (args.value is PickerDateRange) {
                    dateRange.value = args.value;
                  }
                },
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: dateRange.value,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: cairoStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      dateRange.value = null;
                      Get.back();
                    },
                    child: Text(
                      'مسح',
                      style: cairoStyle(fontcolor: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تم',
                      style: cairoStyle(fontcolor: Colors.white),
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
}
