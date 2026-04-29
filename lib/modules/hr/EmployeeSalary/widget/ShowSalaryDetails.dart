import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:hrx/core/function/openSalaryPdf.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/BuildDetailsRow.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/CommitmentDetailRow.dart';
import 'package:hrx/modules/hr/EmployeeSalary/widget/TranslateSalaryKey.dart';

void showDetails(BuildContext context, SalaryResultModel salary) {
  final Salarydetails = salary.salaryDetails as SalaryDetails;
  final bool isMarketing = salary.salarytype == "marketing";
  final bool ishalf = salary.salarytype == "half_time";
  final double hourRate = isMarketing
      ? (Salarydetails.basicSalary.total / totalMonthHoursMarketing)
      : (Salarydetails.basicSalary.total / totalMonthHours);
  final double forgetMoney = Salarydetails.workedHours.forget * hourRate;

  final double shiftPrice = isMarketing
      ? (hourRate * shiftHoursMarketing)
      : (hourRate * shiftHours);
  final double adminCommitmentAmount = ishalf
      ? (Salarydetails.basicSalary.total * AdminCommitmentPercent) / 2
      : (Salarydetails.basicSalary.total * AdminCommitmentPercent);
  double totalallowances = 0;
  final double nethoursMoney = (Salarydetails.workedHours.total) * hourRate;
  final double hrTotalScore = ishalf
      ? (Salarydetails.basicSalary.total * HrEvaluationPercent) / 2
      : (Salarydetails.basicSalary.total * HrEvaluationPercent);
  final double deductedAdminComitted =
      adminCommitmentAmount - Salarydetails.adminCommitmentAmount;
  final double deductedAbsent = (Salarydetails.workedHours.absent * hourRate);
  final double deductedLate = (Salarydetails.workedHours.deducted * hourRate);

  final double deductedHrscore =
      hrTotalScore - Salarydetails.hrEvaluationAmount.amount;
  final double deductedMonthlyAchievement =
      deductedAdminComitted + deductedHrscore;

  Get.bottomSheet(
    Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => openSalaryPdf(salary),
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  ),
                  Expanded(
                    child: Text(
                      "مفردات راتب شهر ${salary.month} - ${salary.name}",
                      textAlign: TextAlign.center,
                      style: cairoStyle(
                        fontSize: 16,
                        fontweight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    BuildDetailsRow(
                      title: "المؤهل",
                      value: salary.qualification,
                    ),
                    const SizedBox(height: 8),
                    BuildDetailsRow(
                      title: "تاريخ التعيين",
                      value:
                          "${salary.appointmentDate.year}-${salary.appointmentDate.month}-${salary.appointmentDate.day}",
                    ),
                    const SizedBox(height: 8),
                    BuildDetailsRow(
                      title: "عدد السنوات الوظيفية",
                      value: "${salary.yearsNumberEmployement} سنة",
                    ),
                    const SizedBox(height: 8),
                    BuildDetailsRow(
                      title: "تاريخ الزيادة القادمة",
                      value:
                          "${Salarydetails.nextRaiseDate.year}-${Salarydetails.nextRaiseDate.month}-${Salarydetails.nextRaiseDate.day}",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            size: 18,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "سعر الساعة: ${hourRate.toStringAsFixed(2)} ج.م",
                            style: cairoStyle(
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                              fontcolor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.work_history_outlined,
                            size: 18,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "سعر الشيفت: ${shiftPrice.toStringAsFixed(2)} ج.م",
                            style: cairoStyle(
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                              fontcolor: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.purple.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: Colors.purple,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "أيام العمل: ${Salarydetails.attendsDays} يوم",
                            style: cairoStyle(
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                              fontcolor: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "تفاصيل الراتب الأساسي",
                style: cairoStyle(
                  fontSize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ...{
                    'salary': Salarydetails.basicSalary.salary,
                    'job_grade': Salarydetails.basicSalary.jobGrade,
                    'experience_salary':
                        Salarydetails.basicSalary.experienceSalary,
                    'other_salary': Salarydetails.basicSalary.otherSalary,
                    'raises': Salarydetails.basicSalary.raises,
                  }.entries
                  .where((entry) => entry.key != 'total' && entry.value > 0)
                  .map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: BuildDetailsRow(
                        title: translateBasicSalaryKey(entry.key),
                        value: "${entry.value.toStringAsFixed(1)} ج.م",
                      ),
                    );
                  }),
              const Divider(),
              BuildDetailsRow(
                title: "إجمالي الراتب الأساسي",
                value:
                    "${Salarydetails.basicSalary.total.toStringAsFixed(1)} ج.م",
                valueColor: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                "هيكل الراتب",
                style: cairoStyle(
                  fontSize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              if (!isMarketing) ...[
                BuildDetailsRow(
                  title: "الالتزام الإداري",
                  value: "${adminCommitmentAmount.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                BuildDetailsRow(
                  title: "تقييم HR",
                  value: "${hrTotalScore.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
              ] else
                BuildDetailsRow(
                  title: "التحقيق الشهري من الزيارات",
                  value:
                      "${(hrTotalScore + adminCommitmentAmount).toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
              const Divider(height: 30),
              BuildDetailsRow(
                title: "إجمالي الراتب",
                value:
                    "${(Salarydetails.basicSalary.total + adminCommitmentAmount + hrTotalScore).toStringAsFixed(1)} ج.م",
                valueColor: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                "تفاصيل الساعات",
                style: cairoStyle(
                  fontSize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ...{
                'total': Salarydetails.workedHours.total,
                'net': Salarydetails.workedHours.net,
                'real': Salarydetails.workedHours.real,
                'friday2': Salarydetails.workedHours.friday2,
                'overtime': Salarydetails.workedHours.overtime,
                'leave': Salarydetails.workedHours.leave,
                'absent': Salarydetails.workedHours.absent,
                'deducted': Salarydetails.workedHours.deducted,
                'fridayAndHoliday': Salarydetails.workedHours.fridayAndHoliday,
                'permission': Salarydetails.workedHours.permission,
              }.entries.map((entry) {
                final double moneyValue = entry.value * hourRate;
                final bool isDeduction =
                    entry.key == 'absent' || entry.key == 'deducted';
                final Color textColor = isDeduction ? Colors.red : Colors.black;
                final Color moneyColor = isDeduction
                    ? Colors.red
                    : Colors.green;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          translateHoursKey(entry.key),
                          style: cairoStyle(fontSize: 14, fontcolor: textColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${entry.value.toStringAsFixed(1)} س",
                          textAlign: TextAlign.center,
                          style: cairoStyle(
                            fontSize: 14,
                            fontweight: FontWeight.bold,
                            fontcolor: textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${moneyValue.toStringAsFixed(1)} ج.م",
                          textAlign: TextAlign.end,
                          style: cairoStyle(
                            fontSize: 14,
                            fontweight: FontWeight.bold,
                            fontcolor: moneyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(height: 30),
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
                title: "صافي الساعات",
                value: "${nethoursMoney.toStringAsFixed(1)} ج.م",
                valueColor: Colors.green,
              ),
              const SizedBox(height: 8),
              if (!isMarketing) ...[
                BuildDetailsRow(
                  title: "الالتزام الإداري",
                  value: "${adminCommitmentAmount.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                BuildDetailsRow(
                  title: "تقييم HR",
                  value: "${hrTotalScore.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
              ] else
                BuildDetailsRow(
                  title: "التحقيق الشهري من الزيارات",
                  value:
                      "${(hrTotalScore + adminCommitmentAmount).toStringAsFixed(1)} ج.م",
                  valueColor: Colors.green,
                ),
              const SizedBox(height: 8),
              ...Salarydetails.lieues.map((lieue) {
                totalallowances += lieue.amount;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: BuildDetailsRow(
                    title: lieue.name,
                    value: "${lieue.amount} ج.م",
                    valueColor: Colors.green,
                  ),
                );
              }),
              BuildDetailsRow(
                title: "المكافأت",
                value: "${Salarydetails.bonuses.toStringAsFixed(1)} ج.م",
                valueColor: Colors.green,
              ),
              const Divider(),
              BuildDetailsRow(
                title: "إجمالي الاستحقاقات",
                value:
                    "${(totalallowances + hrTotalScore + adminCommitmentAmount + nethoursMoney + Salarydetails.bonuses).toStringAsFixed(1)} ج.م",
                valueColor: Colors.blue,
              ),
              const Divider(height: 30),
              Text(
                "قسم المستقطعات",
                style: cairoStyle(
                  fontSize: 14,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.grey,
                ),
              ),

              BuildDetailsRow(
                title: "التأخيرات",
                value: "${deductedLate.toStringAsFixed(1)} ج.م",
                valueColor: Colors.red,
              ),
              Salarydetails.workedHours.forget > 0
                  ? BuildDetailsRow(
                      title: "نسيان البصمة",
                      value: "${forgetMoney.toStringAsFixed(1)} ج.م",
                      valueColor: Colors.red,
                    )
                  : const SizedBox.shrink(),
              BuildDetailsRow(
                title: "الجزائات",
                value:
                    '${Salarydetails.penaltiesAmount.toStringAsFixed(1)} ج.م',
                valueColor: Colors.red,
              ),
              BuildDetailsRow(
                title: "الغيابات",
                value: "${deductedAbsent.toStringAsFixed(1)} ج.م",
                valueColor: Colors.red,
              ),
              BuildDetailsRow(
                title: "خصومات",
                value: "${Salarydetails.rival.toStringAsFixed(1)} ج.م",
                valueColor: Colors.red,
              ),
              BuildDetailsRow(
                title: "سلف",
                value: "${Salarydetails.advance.toStringAsFixed(1)} ج.م",
                valueColor: Colors.red,
              ),
              if (!isMarketing) ...[
                BuildDetailsRow(
                  title: "خصم الألتزام الإداري",
                  value: "${deductedAdminComitted.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.red,
                ),
                BuildDetailsRow(
                  title: "خصم التقييم",
                  value: "${deductedHrscore.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.red,
                ),
              ] else
                BuildDetailsRow(
                  title: "خصم التحقيق الشهري",
                  value: "${deductedMonthlyAchievement.toStringAsFixed(1)} ج.م",
                  valueColor: Colors.red,
                ),
              const Divider(),
              BuildDetailsRow(
                title: "إجمالي المستقطعات",
                value:
                    "${(deductedHrscore + forgetMoney + Salarydetails.penaltiesAmount + Salarydetails.rival + deductedAdminComitted + deductedLate + deductedAbsent + Salarydetails.advance).toStringAsFixed(1)} ج.م",
                valueColor: Colors.red,
              ),
              const Divider(),
              const SizedBox(height: 15),
              !isMarketing
                  ? BuildDetailsRow(
                      title: "الالتزام الإداري",
                      value:
                          "${Salarydetails.adminCommitmentAmount.toStringAsFixed(1)} ج.م",
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommitmentDetailRow(
                      label: "الغياب",
                      value: "${Salarydetails.absenceDays} أيام",
                      isSuccess: isMarketing
                          ? null
                          : Salarydetails.absenceDays == 0,
                    ),

                    CommitmentDetailRow(
                      label: "التأخير",
                      value:
                          "${Salarydetails.lateCount.total} ${isMarketing ? '' : '/ 4 مرات'} ",
                      isSuccess: isMarketing
                          ? null
                          : Salarydetails.lateCount.total < 4,
                    ),
                    if (Salarydetails.lateCount.total > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (Salarydetails.lateCount.quarter > 0)
                              Text(
                                "- ربع يوم (15د): ${Salarydetails.lateCount.quarter}",
                                style: cairoStyle(
                                  fontSize: 12,
                                  fontcolor: Colors.grey,
                                ),
                              ),
                            if (Salarydetails.lateCount.halfDay > 0)
                              Text(
                                "- نصف يوم (30د): ${Salarydetails.lateCount.halfDay}",
                                style: cairoStyle(
                                  fontSize: 12,
                                  fontcolor: Colors.grey,
                                ),
                              ),
                            if (Salarydetails.lateCount.fullDay > 0)
                              Text(
                                "- يوم كامل (60د): ${Salarydetails.lateCount.fullDay}",
                                style: cairoStyle(
                                  fontSize: 12,
                                  fontcolor: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),

                    CommitmentDetailRow(
                      label: "الجزائات",
                      value: Salarydetails.penaltiesCount.toStringAsFixed(0),
                      isSuccess: isMarketing
                          ? null
                          : Salarydetails.penaltiesCount == 0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              BuildDetailsRow(
                title: "تقييم HR",
                value: isMarketing
                    ? "${Salarydetails.hrEvaluationAmount.score.toString()} درجة"
                    : "${Salarydetails.hrEvaluationAmount.amount} ج.م",
                subValue: isMarketing
                    ? null
                    : '${Salarydetails.hrEvaluationAmount.score.toString()} درجة',
              ),
              const SizedBox(height: 12),
              const Divider(height: 30),
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
  );
}
