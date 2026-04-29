import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/core/constant/staticNumbers.dart';
import 'package:printing/printing.dart';

String _translateBasicSalaryKey(String key) {
  switch (key) {
    case 'salary':
      return 'الراتب الأساسي';
    case 'job_grade':
      return 'البدل الوظيفي';
    case 'experience_salary':
      return 'بدل الخبرة';
    case 'other_salary':
      return 'بدلات أخرى';
    case 'raises':
      return 'الزيادات السنوية';
    default:
      return key;
  }
}

String _translateHoursKey(String key) {
  final map = {
    'total': 'إجمالي الساعات',
    'absent': 'ساعات الغياب',
    'deducted': 'ساعات الخصم',
    'fridayAndHoliday': 'أيام الجمعة والعطلات',
    'net': 'صافي الساعات',
    'real': 'السعات الفعلية',
    'leave': 'أجازة',
    'overtime': 'اضافي',
    'friday2': 'جمعة حضور',
    'permission': 'إذن',
  };
  return map[key] ?? key;
}

Future<Uint8List> generateSalaryPdfTable(SalaryResultModel salary) async {
  final pdf = pw.Document();

  final font = await PdfGoogleFonts.cairoRegular();
  final boldFont = await PdfGoogleFonts.cairoBold();

  final bool isMarketing = salary.salarytype == "marketing";
  final bool ishalf = salary.salarytype == "half_time";

  final SalaryDetails salaryDetails = salary.salaryDetails as SalaryDetails;

  final double hourRate = isMarketing
      ? salaryDetails.basicSalary.total / totalMonthHoursMarketing
      : salaryDetails.basicSalary.total / totalMonthHours;
  final double forgetMoney = salaryDetails.workedHours.forget * hourRate;
  final double shiftPrice = isMarketing
      ? hourRate * shiftHoursMarketing
      : hourRate * shiftHours;

  final double adminCommitmentAmount = ishalf
      ? (salaryDetails.basicSalary.total * AdminCommitmentPercent) / 2
      : salaryDetails.basicSalary.total * AdminCommitmentPercent;
  final double hrTotalScore = ishalf
      ? (salaryDetails.basicSalary.total * HrEvaluationPercent) / 2
      : (salaryDetails.basicSalary.total * HrEvaluationPercent);
  final double deductedHrscore =
      hrTotalScore - salaryDetails.hrEvaluationAmount.amount;

  final double nethoursMoney = (salaryDetails.workedHours.total) * hourRate;
  final double deductedAdminComitted =
      adminCommitmentAmount - salaryDetails.adminCommitmentAmount;
  final double deductedAbsent = salaryDetails.workedHours.absent * hourRate;
  final double deductedLate = salaryDetails.workedHours.deducted * hourRate;
  final double deductedMonthlyAchievement =
      deductedAdminComitted + deductedHrscore;

  double totalAllowances = 0;
  for (var l in salaryDetails.lieues) totalAllowances += l.amount;

  final double totalEntitlements =
      totalAllowances +
      hrTotalScore +
      adminCommitmentAmount +
      nethoursMoney +
      salaryDetails.bonuses;

  final double totalDeductions =
      deductedHrscore +
      salaryDetails.penaltiesAmount +
      salaryDetails.rival +
      salaryDetails.advance +
      deductedAdminComitted +
      forgetMoney +
      deductedLate +
      deductedAbsent;

  pw.Widget buildRow(
    String label,
    String value, {
    PdfColor? color,
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              font: isBold ? boldFont : font,
              fontSize: 9,
              color: color,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: isBold ? boldFont : font,
              fontSize: 9,
              color: color,
              fontWeight: isBold ? pw.FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget buildSectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 5, bottom: 2),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          font: boldFont,
          fontSize: 10,
          color: PdfColors.grey700,
        ),
      ),
    );
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(base: font, bold: boldFont),
      build: (context) {
        return [
          pw.Center(
            child: pw.Text(
              "مفردات راتب شهر ${salary.month} - ${salary.name}",
              style: pw.TextStyle(
                font: boldFont,
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Column(
              children: [
                buildRow("المؤهل", salary.qualification),
                buildRow(
                  "تاريخ التعيين",
                  "${salary.appointmentDate.year}-${salary.appointmentDate.month}-${salary.appointmentDate.day}",
                ),
                buildRow(
                  "عدد السنوات الوظيفية",
                  "${salary.yearsNumberEmployement} سنة",
                ),
                buildRow(
                  "تاريخ الزيادة القادمة",
                  "${salaryDetails.nextRaiseDate.year}-${salaryDetails.nextRaiseDate.month}-${salaryDetails.nextRaiseDate.day}",
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.blue50,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "سعر الساعة",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColors.blue,
                        ),
                      ),
                      pw.Text(
                        "${hourRate.toStringAsFixed(2)} ج.م",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldFont,
                          color: PdfColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(width: 5),
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.orange50,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "سعر الشيفت",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColors.orange,
                        ),
                      ),
                      pw.Text(
                        "${shiftPrice.toStringAsFixed(2)} ج.م",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldFont,
                          color: PdfColors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(width: 5),
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.purple50,
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "أيام العمل",
                        style: const pw.TextStyle(
                          fontSize: 8,
                          color: PdfColors.purple,
                        ),
                      ),
                      pw.Text(
                        "${salaryDetails.attendsDays} يوم",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldFont,
                          color: PdfColors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle("تفاصيل الراتب الأساسي"),
                    ...{
                      'salary': salaryDetails.basicSalary.salary,
                      'job_grade': salaryDetails.basicSalary.jobGrade,
                      'experience_salary':
                          salaryDetails.basicSalary.experienceSalary,
                      'other_salary': salaryDetails.basicSalary.otherSalary,
                      'raises': salaryDetails.basicSalary.raises,
                    }.entries.where((e) => e.key != 'total' && e.value > 0).map(
                      (e) {
                        return buildRow(
                          _translateBasicSalaryKey(e.key),
                          "${e.value.toStringAsFixed(1)} ج.م",
                        );
                      },
                    ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الراتب الأساسي",
                      "${salaryDetails.basicSalary.total.toStringAsFixed(1)} ج.م",
                      color: PdfColors.blue,
                      isBold: true,
                    ),
                    buildSectionTitle("هيكل الراتب"),
                    if (!isMarketing) ...[
                      buildRow(
                        "الالتزام الإداري",
                        "${adminCommitmentAmount.toStringAsFixed(1)} ج.م",
                      ),
                      buildRow(
                        "تقييم HR",
                        "${hrTotalScore.toStringAsFixed(1)} ج.م",
                      ),
                    ] else
                      buildRow(
                        "التحقيق الشهري من الزيارات",
                        "${(adminCommitmentAmount + hrTotalScore).toStringAsFixed(1)} ج.م",
                      ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الراتب",
                      "${(salaryDetails.basicSalary.total + adminCommitmentAmount + hrTotalScore).toStringAsFixed(1)} ج.م",
                      color: PdfColors.blue,
                      isBold: true,
                    ),
                    buildSectionTitle("تفاصيل الساعات"),
                    ...{
                      'total': salaryDetails.workedHours.total,
                      'net': salaryDetails.workedHours.net,
                      'real': salaryDetails.workedHours.real,
                      'friday2': salaryDetails.workedHours.friday2,
                      'absent': salaryDetails.workedHours.absent,
                      'deducted': salaryDetails.workedHours.deducted,
                      'fridayAndHoliday':
                          salaryDetails.workedHours.fridayAndHoliday,
                      'permission': salaryDetails.workedHours.permission,
                    }.entries.map((entry) {
                      final double moneyValue = entry.value * hourRate;
                      final bool isDeduction =
                          entry.key == 'absent' || entry.key == 'deducted';
                      final PdfColor color = isDeduction
                          ? PdfColors.red
                          : PdfColors.black;
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              _translateHoursKey(entry.key),
                              style: pw.TextStyle(fontSize: 9, color: color),
                            ),
                            pw.Text(
                              "${entry.value.toStringAsFixed(1)} س",
                              style: pw.TextStyle(
                                fontSize: 8,
                                font: boldFont,
                                color: color,
                              ),
                            ),
                            pw.Text(
                              "${moneyValue.toStringAsFixed(1)} ج.م",
                              style: pw.TextStyle(
                                fontSize: 8,
                                font: boldFont,
                                color: isDeduction
                                    ? PdfColors.red
                                    : PdfColors.green,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              pw.SizedBox(width: 15),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle("قسم الاستحقاقات"),
                    buildRow(
                      "صافي الساعات",
                      "${nethoursMoney.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),

                    if (!isMarketing) ...[
                      buildRow(
                        "الالتزام الإداري",
                        "${adminCommitmentAmount.toStringAsFixed(1)} ج.م",
                        color: PdfColors.green,
                      ),
                      buildRow(
                        "تقييم HR",
                        "${hrTotalScore.toStringAsFixed(1)} ج.م",
                        color: PdfColors.green,
                      ),
                    ] else
                      buildRow(
                        "التحقيق الشهري من الزيارات",
                        "${(adminCommitmentAmount + hrTotalScore).toStringAsFixed(1)} ج.م",
                        color: PdfColors.green,
                      ),

                    ...salaryDetails.lieues.map(
                      (l) => buildRow(
                        l.name,
                        "${l.amount} ج.م",
                        color: PdfColors.green,
                      ),
                    ),
                    buildRow(
                      "المكافأت",
                      "${salaryDetails.bonuses.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الاستحقاقات",
                      "${totalEntitlements.toStringAsFixed(1)} ج.م",
                      color: PdfColors.blue,
                      isBold: true,
                    ),
                    buildSectionTitle("قسم المستقطعات"),
                    buildRow(
                      "التأخيرات",
                      "${deductedLate.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "الجزائات",
                      "${salaryDetails.penaltiesAmount.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "الغيابات",
                      "${deductedAbsent.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "خصومات",
                      "${salaryDetails.rival.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "سلف",
                      salaryDetails.advance.toStringAsFixed(1),
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "نسيان البصمة",
                      forgetMoney.toStringAsFixed(1),
                      color: PdfColors.red,
                    ),
                    if (!isMarketing) ...[
                      buildRow(
                        "خصم الألتزام الإداري",
                        "${deductedAdminComitted.toStringAsFixed(1)} ج.م",
                        color: PdfColors.red,
                      ),
                      buildRow(
                        "خصم التقييم",
                        "${deductedHrscore.toStringAsFixed(1)} ج.م",
                        color: PdfColors.red,
                      ),
                    ] else
                      buildRow(
                        "خصم التحقيق الشهري",
                        "${deductedMonthlyAchievement.toStringAsFixed(1)} ج.م",
                        color: PdfColors.red,
                      ),

                    pw.Divider(),
                    buildRow(
                      "إجمالي المستقطعات",
                      "${totalDeductions.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (!isMarketing)
                  pw.Text(
                    "تفاصيل الالتزام الإداري",
                    style: pw.TextStyle(font: boldFont, fontSize: 10),
                  ),
                pw.SizedBox(height: 5),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: buildRow(
                        "الغياب",
                        "${salaryDetails.absenceDays} أيام ${salaryDetails.absenceDays == 0 ? '(✓)' : '(X)'}",
                        color: salaryDetails.absenceDays == 0
                            ? PdfColors.green
                            : PdfColors.red,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: buildRow(
                        "الجزائات",
                        "${salaryDetails.penaltiesCount.toStringAsFixed(0)} ${salaryDetails.penaltiesCount == 0 ? '(✓)' : '(X)'}",
                        color: salaryDetails.penaltiesCount == 0
                            ? PdfColors.green
                            : PdfColors.red,
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: buildRow(
                        "التأخير",
                        "${salaryDetails.lateCount.total} ${isMarketing ? '' : ' / 4 مرات '} ${salaryDetails.lateCount.total < 4 ? '(✓)' : '(X)'}",
                        color: salaryDetails.lateCount.total < 4
                            ? PdfColors.green
                            : PdfColors.red,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(child: pw.Container()),
                  ],
                ),
                if (salaryDetails.lateCount.total > 0) ...[
                  if (salaryDetails.lateCount.quarter > 0)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 10),
                      child: pw.Text(
                        "- ربع يوم (15د): ${salaryDetails.lateCount.quarter}",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: font,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                  if (salaryDetails.lateCount.halfDay > 0)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 10),
                      child: pw.Text(
                        "- نصف يوم (30د): ${salaryDetails.lateCount.halfDay}",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: font,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                  if (salaryDetails.lateCount.fullDay > 0)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 10),
                      child: pw.Text(
                        "- يوم كامل (60د): ${salaryDetails.lateCount.fullDay}",
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: font,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                ],
                pw.SizedBox(height: 5),
                pw.Divider(),
                pw.Text(
                  "تقييم HR",
                  style: pw.TextStyle(font: boldFont, fontSize: 10),
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: buildRow(
                        "الدرجة",
                        "${salaryDetails.hrEvaluationAmount.score} درجة",
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    if (!isMarketing)
                      pw.Expanded(
                        child: buildRow(
                          "القيمة",
                          "${salaryDetails.hrEvaluationAmount.amount} ج.م",
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColors.green50,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: PdfColors.green),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "صافي الراتب",
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 14,
                    color: PdfColors.green900,
                  ),
                ),
                pw.Text(
                  "${salary.finalSalary.toStringAsFixed(2)} ج.م",
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 16,
                    color: PdfColors.green900,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    ),
  );

  return pdf.save();
}
