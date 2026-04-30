import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/function/openSalaryPdf.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/BuildDetailsRow.dart';

void showShiftSalaryDetails(
  BuildContext context,
  ShiftSalaryDetails details,
  SalaryResultModel salary,
) {
  final double shiftsSalary = details.shiftsCount * details.shiftPrice;

  final double totalAllowances =
      shiftsSalary + details.casesAmount + details.dyeAmount + details.bonuses;

  final double totalDeductions = details.rivals +
      details.penalties +
      details.detectedhrShiftAmount +
      details.advance;

  Get.bottomSheet(
    Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.isDesktop(context) ? 900 : double.infinity,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          openSalaryPdf(salary);
                        },
                        icon:
                            const Icon(Icons.picture_as_pdf, color: Colors.red),
                      ),
                      const SizedBox(width: 5),
                      Center(
                        child: Text(
                          "تفاصيل راتب الشيفتات - ${salary.name}",
                          style: cairoStyle(
                            fontSize: 16.spAdaptive(context),
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// QUICK INFO
                  Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChip(
                          context: context,
                          icon: Icons.work,
                          label: "عدد الشيفتات",
                          value: "${details.shiftsCount}",
                          color: Colors.blue,
                        ),
                        _buildChip(
                          context: context,
                          icon: Icons.attach_money,
                          label: "سعر الشيفت",
                          value: "${details.shiftPrice}",
                          color: Colors.orange,
                        ),
                        _buildChip(
                          context: context,
                          icon: Icons.calculate,
                          label: "إجمالي الشيفت",
                          value: shiftsSalary.toStringAsFixed(1),
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ===============================
                  /// تفنيط الراتب
                  /// ===============================
                  Text(
                    "تفنيط الراتب",
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.bold,
                      fontcolor: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  BuildDetailsRow(
                    title: "عدد الجزاءات",
                    value: details.penaltiesCount.toString(),
                  ),

                  BuildDetailsRow(
                    title: "عدد الحالات",
                    value: details.cases.toString(),
                  ),

                  BuildDetailsRow(
                    title: "عدد حالات الصبغة",
                    value: details.dyeCases.toString(),
                  ),

                  const Divider(height: 30),

                  /// ===============================
                  /// قسم الاستحقاقات
                  /// ===============================
                  Text(
                    "قسم الاستحقاقات",
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.bold,
                      fontcolor: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  BuildDetailsRow(
                    title: "فلوس الشيفتات",
                    value: "${shiftsSalary.toStringAsFixed(1)} ج.م",
                    valueColor: Colors.green,
                  ),

                  BuildDetailsRow(
                    title: "فلوس الحالات",
                    value: "${details.casesAmount} ج.م",
                    valueColor: Colors.green,
                  ),

                  BuildDetailsRow(
                    title: "فلوس حالات الصبغة",
                    value: "${details.dyeAmount} ج.م",
                    valueColor: Colors.green,
                  ),

                  BuildDetailsRow(
                    title: "المكافآت",
                    value: "${details.bonuses} ج.م",
                    valueColor: Colors.green,
                  ),

                  const Divider(),

                  BuildDetailsRow(
                    title: "إجمالي الاستحقاقات",
                    value: "${totalAllowances.toStringAsFixed(1)} ج.م",
                    valueColor: Colors.blue,
                  ),

                  const Divider(height: 30),

                  /// ===============================
                  /// قسم الاستقطاعات
                  /// ===============================
                  Text(
                    "قسم الاستقطاعات",
                    style: cairoStyle(
                      fontSize: 14,
                      fontweight: FontWeight.bold,
                      fontcolor: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  BuildDetailsRow(
                    title: "الجزاءات",
                    value: "${details.rivals} ج.م",
                    valueColor: Colors.red,
                  ),

                  BuildDetailsRow(
                    title: "الخصومات",
                    value: "${details.penalties} ج.م",
                    valueColor: Colors.red,
                  ),

                  BuildDetailsRow(
                    title: "سلف",
                    value: "${details.advance} ج.م",
                    valueColor: Colors.red,
                  ),

                  BuildDetailsRow(
                    title: "خصم التقييم الشهري",
                    value: "${details.detectedhrShiftAmount} ج.م",
                    valueColor: Colors.red,
                  ),

                  const Divider(),

                  BuildDetailsRow(
                    title: "إجمالي الاستقطاعات",
                    value: "${totalDeductions.toStringAsFixed(1)} ج.م",
                    valueColor: Colors.red,
                  ),

                  const Divider(height: 30),

                  /// ===============================
                  /// صافي الراتب
                  /// ===============================
                  BuildDetailsRow(
                    title: "صافي الراتب",
                    value: "${salary.finalSalary.toStringAsFixed(2)} ج.م",
                    valueColor: Colors.green,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// CHIP
Widget _buildChip({
  required BuildContext context,
  required IconData icon,
  required String label,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18.spAdaptive(context), color: color),
        const SizedBox(width: 6),
        Text(
          "$label: $value",
          style: cairoStyle(
            fontSize: 13.spAdaptive(context),
            fontweight: FontWeight.bold,
            fontcolor: color,
          ),
        ),
      ],
    ),
  );
}
