import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/document_model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/controllers/employee_documents_controller.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Employees/widget/AddEmployee/buildTextField.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/PdfViewScreen.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class EmployeeDocumentsScreen extends StatelessWidget {
  const EmployeeDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeDocumentsController());
    final isdesktop = Responsive.isDesktop(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FD),
        appBar: CustomAppBar(title: 'مستندات ${controller.employee.name}'),

        body: Obx(() {
          if (controller.hasError.value) {
            return NoInternetWidget(onPressed: controller.fetchDocuments);
          }

          if (controller.isLoading.value) {
            return Loadingcircular();
          }

          if (controller.documents.isEmpty) {
            return _emptyState();
          }

          //  Responsive Switch
          if (isdesktop) {
            return _webLayout(controller);
          } else if (Responsive.isTablet(context)) {
            return _tabletLayout(controller);
          } else {
            return _mobileLayout(controller);
          }
        }),

        floatingActionButton: Get.width < 600
            ? FloatingActionButton.extended(
                backgroundColor: Appcolors.primarycolor,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.spAdaptive(context),
                ),
                label: Text(
                  'إضافة مستند',
                  style: cairoStyle(
                    fontweight: FontWeight.bold,
                    fontcolor: Colors.white,
                  ),
                ),
                onPressed: () => _showAddDocumentDialog(context, controller),
              )
            : FloatingActionButton(
                backgroundColor: Appcolors.primarycolor,
                onPressed: () => _showAddDocumentDialog(context, controller),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.spAdaptive(context),
                ),
              ),
      ),
    );
  }

  // ================= Layouts =================

  Widget _mobileLayout(controller) {
    return _buildList(controller);
  }

  Widget _tabletLayout(controller) {
    return _buildGrid(controller, crossAxisCount: 2);
  }

  Widget _webLayout(controller) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000.w),
        child: _buildGrid(controller, crossAxisCount: 2),
      ),
    );
  }

  // ================= List =================

  Widget _buildList(controller) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      itemCount: controller.documents.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return _documentCard(controller.documents[index], controller);
      },
    );
  }

  // ================= Grid =================

  Widget _buildGrid(controller, {required int crossAxisCount}) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.documents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        return _documentCard(controller.documents[index], controller);
      },
    );
  }

  // ================= Card =================

  Widget _documentCard(DocumentModel doc, controller) {
    final isPdf = doc.documentUrl.toLowerCase().endsWith('.pdf');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          if (isPdf) {
            Get.to(() => PdfViewerScreen(url: doc.documentUrl));
          } else {
            Get.to(
              () => Scaffold(
                appBar: CustomAppBar(title: 'عرض المستند'),
                body: Center(child: Image.network(doc.documentUrl)),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52.spAdaptive(Get.context!),
                height: 52.spAdaptive(Get.context!),
                decoration: BoxDecoration(
                  color: isPdf
                      ? const Color(0xFFFFF5F5)
                      : const Color(0xFFE6F2FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                  color: isPdf
                      ? const Color(0xFFFF4D4F)
                      : const Color(0xFF1890FF),
                  size: 28.spAdaptive(Get.context!),
                ),
              ),
              SizedBox(width: 12.spAdaptive(Get.context!)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.documentName,
                      style: cairoStyle(
                        fontSize: 14.spAdaptive(Get.context!),
                        fontweight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      doc.createdAt.toString().substring(0, 10),
                      style: cairoStyle(
                        fontcolor: Colors.grey,
                        fontSize: 12.spAdaptive(Get.context!),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 24.spAdaptive(Get.context!),
                ),
                onPressed: () => _showDeleteDialog(controller, doc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= Empty =================

  Widget _emptyState() {
    return Center(
      child: Text(
        'لا توجد مستندات',
        style: cairoStyle(
          fontSize: Responsive.isDesktop(Get.context!)
              ? 13.spAdaptive(Get.context!)
              : 17.spAdaptive(Get.context!),
        ),
      ),
    );
  }

  // ================= Dialogs =================

  void _showAddDocumentDialog(context, controller) {
    final width = MediaQuery.of(context).size.width;

    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: width < 600 ? 15 : 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(
                controller: controller.nameController,
                label: 'اسم المستند',
                icon: Icons.edit,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    controller.pickedFile.value = result.files.first;
                  }
                },
                child: const Text("اختيار ملف"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.addDocument(
                    controller.nameController.text,
                    controller.pickedFile.value!,
                  );
                  Get.back();
                },
                child: Text(
                  "رفع",
                  style: cairoStyle(fontweight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(controller, DocumentModel doc) {
    Get.dialog(
      AlertDialog(
        title: Text("حذف ${doc.documentName}"),
        actions: [
          TextButton(onPressed: Get.back, child: const Text("إلغاء")),
          ElevatedButton(
            onPressed: () {
              controller.deleteDocument(doc);
              Get.back();
            },
            child: const Text("حذف"),
          ),
        ],
      ),
    );
  }
}
