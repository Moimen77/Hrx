import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';

Future<Uint8List> generateShiftSalaryPdf(
  SalaryResultModel salary,
  ShiftSalaryDetails details,
) async {
  final pdf = pw.Document();

  final font = await PdfGoogleFonts.cairoRegular();
  final boldFont = await PdfGoogleFonts.cairoBold();

  final double shiftsSalary = details.shiftsCount * details.shiftPrice;

  final double totalAllowances =
      shiftsSalary + details.casesAmount + details.dyeAmount + details.bonuses;

  final double totalDeductions =
      details.rivals +
      details.penalties +
      details.detectedhrShiftAmount +
      details.advance;

  pw.Widget buildRow(
    String label,
    String value, {
    PdfColor? color,
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
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
              "مفردات راتب شيفتات شهر ${salary.month}",
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
                buildRow("الاسم", salary.name),
                buildRow("المؤهل", salary.qualification),
                buildRow(
                  "تاريخ التعيين",
                  "${salary.appointmentDate.year}-${salary.appointmentDate.month}-${salary.appointmentDate.day}",
                ),
                buildRow(
                  "عدد السنوات الوظيفية",
                  "${salary.yearsNumberEmployement} سنة",
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle("تفاصيل الشيفتات"),
                    buildRow("عدد الشيفتات", details.shiftsCount.toString()),
                    buildRow(
                      "سعر الشيفت",
                      "${details.shiftPrice.toStringAsFixed(1)} ج.م",
                    ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الشيفتات",
                      "${shiftsSalary.toStringAsFixed(1)} ج.م",
                      color: PdfColors.blue,
                      isBold: true,
                    ),
                    buildSectionTitle("قسم الاستحقاقات"),
                    buildRow(
                      "فلوس الشيفتات",
                      "${shiftsSalary.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),
                    buildRow(
                      "فلوس الحالات (${details.cases})",
                      "${details.casesAmount.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),
                    buildRow(
                      "فلوس حالات الصبغة (${details.dyeCases})",
                      "${details.dyeAmount.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),
                    buildRow(
                      "المكافآت",
                      "${details.bonuses.toStringAsFixed(1)} ج.م",
                      color: PdfColors.green,
                    ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الاستحقاقات",
                      "${totalAllowances.toStringAsFixed(1)} ج.م",
                      color: PdfColors.blue,
                      isBold: true,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 15),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle("إحصائيات"),
                    buildRow("عدد الجزاءات", details.penaltiesCount.toString()),
                    buildRow("عدد الحالات", details.cases.toString()),
                    buildRow("عدد حالات الصبغة", details.dyeCases.toString()),
                    buildRow("تقييم HR", "${details.hrEvaluation.score}"),
                    buildSectionTitle("قسم الاستقطاعات"),
                    buildRow(
                      "الجزاءات",
                      "${details.penalties.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "السلف",
                      "${details.advance.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "الخصومات",
                      "${details.rivals.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    buildRow(
                      "خصم التقييم الشهري",
                      "${details.detectedhrShiftAmount.toStringAsFixed(1)} ج.م",
                      color: PdfColors.red,
                    ),
                    pw.Divider(),
                    buildRow(
                      "إجمالي الاستقطاعات",
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
            padding: const pw.EdgeInsets.all(12),
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
                  "${salary.finalSalary.toStringAsFixed(1)} ج.م",
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 16,
                    color: PdfColors.green900,
                    fontWeight: pw.FontWeight.bold,
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
