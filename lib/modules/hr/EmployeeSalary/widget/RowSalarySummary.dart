import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/InfoSalaryitem.dart';

class RowSalarySummary extends StatelessWidget {
  const RowSalarySummary({super.key, required this.salary});
  final SalaryResultModel salary;

  @override
  Widget build(BuildContext context) {
    final bool isshifts = salary.salarytype == 'shifts';
    final Salarydetails = salary.salaryDetails;

    return Wrap(
      spacing: 20,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 90,
          child: Infosalaryitem(
            label: isshifts ? "سعر الشفت" : "الأساسي",
            value: isshifts
                ? "${(Salarydetails as ShiftSalaryDetails).shiftPrice}"
                : "${(Salarydetails as SalaryDetails).basicSalary.total}",
          ),
        ),
        SizedBox(
          width: 90,
          child: Infosalaryitem(
            label: isshifts ? "ايام الحضور" : "ساعات العمل",
            value: isshifts
                ? "${(Salarydetails as ShiftSalaryDetails).shiftsCount}"
                : (Salarydetails as SalaryDetails)
                    .workedHours
                    .total
                    .toStringAsFixed(1),
          ),
        ),
        SizedBox(
          width: 90,
          child: Infosalaryitem(
            label: "الجزائات",
            value: isshifts
                ? ((Salarydetails as ShiftSalaryDetails)
                    .penalties
                    .toStringAsFixed(1))
                : ((Salarydetails as SalaryDetails)
                    .penaltiesAmount
                    .toStringAsFixed(1)),
          ),
        ),
      ],
    );
  }
}
