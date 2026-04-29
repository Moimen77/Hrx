import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/hr/EmployeeSalary/controller/SalaryController.dart';

void showShiftCasesDialog({
  required BuildContext context,
  required int employeeId,
  required SalaryController controller,
}) {
  final casesController = TextEditingController();
  final dyeController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          width: Get.width * .85,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * .05,
            vertical: Get.height * .025,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TITLE
              Row(
                children: [
                  const Icon(
                    Icons.medical_services_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: Get.width * .02),
                  Text(
                    "تسجيل الحالات",
                    style: cairoStyle(
                      fontSize: 16,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: Get.height * .025),

              /// CASES FIELD
              TextField(
                controller: casesController,
                keyboardType: TextInputType.number,
                style: cairoStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "عدد الحالات",
                  labelStyle: cairoStyle(fontSize: 13),
                  prefixIcon: const Icon(Icons.people_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: Get.height * .02),

              /// DYE CASES FIELD
              TextField(
                controller: dyeController,
                keyboardType: TextInputType.number,
                style: cairoStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "عدد حالات الصبغة",
                  labelStyle: cairoStyle(fontSize: 13),
                  prefixIcon: const Icon(Icons.color_lens_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: Get.height * .03),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * .015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "إلغاء",
                        style: cairoStyle(
                          fontSize: 14,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: Get.width * .03),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * .015,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "حفظ",
                        style: cairoStyle(
                          fontSize: 14,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        final cases = int.tryParse(casesController.text) ?? 0;
                        final dyeCases = int.tryParse(dyeController.text) ?? 0;

                        await controller.updateCases(
                          employeeId: employeeId,
                          cases: cases,
                          dyeCases: dyeCases,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
