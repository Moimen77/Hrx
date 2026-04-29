import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/add_raise_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/buildTextField.dart';

class AddRaiseDialog extends StatelessWidget {
  final EmployeeModel employee;
  const AddRaiseDialog({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddRaiseController(employee: employee));

    return Dialog(
      constraints: BoxConstraints(maxWidth: 300.spAdaptive(context)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'إضافة زيادة سنوية لـ  \n${employee.name}',
                  textAlign: TextAlign.center,
                  style: cairoStyle(fontweight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: controller.amountController,
                  label: 'قيمة الزيادة',
                  keyboardType: TextInputType.number,
                  icon: Icons.attach_money,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال قيمة الزيادة';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'الرجاء إدخال قيمة صحيحة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  controller: controller.dateController,
                  readOnly: true,
                  label: 'تاريخ السريان',
                  keyboardType: TextInputType.datetime,
                  onTap: controller.pickDate,
                  icon: Icons.calendar_today,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء اختيار تاريخ السريان';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'إلغاء',
                          style: cairoStyle(
                            fontcolor: Colors.blueAccent,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.submit,
                        child: Obx(() {
                          return controller.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'تأكيد',
                                  style: cairoStyle(
                                    fontcolor: Colors.black,
                                    fontSize: 16,
                                    fontweight: FontWeight.bold,
                                  ),
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
