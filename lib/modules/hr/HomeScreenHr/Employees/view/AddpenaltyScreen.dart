import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/FormatedDate.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/AddPenaltyController.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/transaction_type_enum.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';
import 'package:hrx/shared_widgets/TextFieldApp.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTransactionController());

    return Scaffold(
      appBar: CustomAppBar(title: controller.pageTitle),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('النوع'),
                _buildDropdown(controller),
                const Gap(20),
                _buildSectionTitle('السبب'),
                Textfieldapp(
                  controller: controller.reasonController,
                  hint: controller.reasonHint,
                  suffixIcon: Icon(Icons.restart_alt_outlined),
                ),
                const Gap(20),
                _buildSectionTitle('القيمة'),
                Row(
                  children: [
                    Expanded(
                      child: Textfieldapp(
                        controller: controller.amountController,
                        hint: 'مثال: 100',
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const Gap(10),
                    controller.transactionType == TransactionType.penalty
                        ? Obx(
                            () => Column(
                              children: [
                                Text(
                                  controller.isPercentage.value
                                      ? 'يوم'
                                      : 'جنيه',
                                  style: cairoStyle(),
                                ),
                                Switch(
                                  value: controller.isPercentage.value,
                                  onChanged: controller.toggleIsPercentage,
                                  activeColor: Appcolors.primarycolor,
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                const Gap(20),
                _buildSectionTitle('التاريخ'),
                _buildDatePicker(context, controller),
                const Gap(40),
                Obx(
                  () => Buttonapp(
                    OnTap: controller.saveTransaction,
                    text: controller.saveButtonText,
                    isloading: controller.isLoading.value,
                    Loadingtext: 'جاري الحفظ...',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: cairoStyle(fontSize: 16, fontweight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDropdown(AddTransactionController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedType.value,
            items: controller.availableTypes
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type, style: cairoStyle()),
                  ),
                )
                .toList(),
            onChanged: controller.setSelectedType,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    AddTransactionController controller,
  ) {
    return InkWell(
      onTap: () => controller.pickDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                formatDayMonth(controller.transactionDate.value),
                style: cairoStyle(fontSize: 16),
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: Appcolors.primarycolor,
            ),
          ],
        ),
      ),
    );
  }
}
