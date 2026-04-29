import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/cleanFileName.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/document_model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/services/document_service.dart';

class EmployeeDocumentsController extends GetxController
    with NetworkAwareMixin {
  final DocumentService _documentService = DocumentService();
  late final EmployeeModel employee;

  var documents = <DocumentModel>[].obs;
  Rx<PlatformFile?> pickedFile = Rx<PlatformFile?>(null);
  var isLoading = true.obs;
  late TextEditingController nameController;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    employee = Get.arguments as EmployeeModel;
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final result = await _documentService.getDocuments(employee.id!);
      documents.assignAll(result);
    } catch (e) {
      hasError.value = true;
      Get.snackbar('خطأ', 'فشل في جلب المستندات: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDocument(
    String documentName,
    PlatformFile platformFile,
  ) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      final file = File(platformFile.path!);
      final fileNameCleaned = generateSafeFileName(platformFile.name);

      final filePath =
          '${employee.id}/${DateTime.now().millisecondsSinceEpoch}_$fileNameCleaned';

      await _documentService.addDocument(
        employeeId: employee.id!,
        documentName: documentName,
        file: file,
        filePath: filePath,
      );
      Get.back();
      fetchDocuments();
      Get.snackbar('نجاح', 'تمت إضافة المستند بنجاح');
    } catch (e) {
      print('Error adding document: $e');
      Get.snackbar('خطأ', 'فشل في إضافة المستند: ${e.toString()}');
    }
  }

  Future<void> deleteDocument(DocumentModel document) async {
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      await _documentService.deleteDocument(document.id, document.documentUrl);
      documents.removeWhere((d) => d.id == document.id);
      Get.snackbar('نجاح', 'تم حذف المستند بنجاح');
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في حذف المستند: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
