import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/data/models/EmployeeSalaryResult.dart';
import 'package:hrx/modules/Pdf/GenerateSalaryPdf1.dart';
import 'package:hrx/modules/Pdf/generateShiftsSalaryPdf.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';
import 'package:printing/printing.dart';

void openSalaryPdf(SalaryResultModel salary) {
  final salaryDetails = salary.salaryDetails;

  Navigator.push(
    Get.context!,
    MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(title: "معاينة التقرير"),
        body: PdfPreview(
          build: (format) => salaryDetails is ShiftSalaryDetails
              ? generateShiftSalaryPdf(salary, salaryDetails)
              : generateSalaryPdfTable(salary),
        ),
      ),
    ),
  );
}
