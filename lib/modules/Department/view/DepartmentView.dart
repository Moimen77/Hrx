import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/shared_widgets/LoadingCircular.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class DepartmentsScreen extends GetView<DepartmentController> {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'الأقسام'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Loadingcircular();
          }
          if (controller.departments.isEmpty) {
            return Center(
              child: Text(
                'لا توجد أقسام مضافة حتى الآن',
                style: cairoStyle(fontSize: 16, fontcolor: Colors.grey),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    Colors.grey.shade100,
                  ),
                  headingTextStyle: cairoStyle(
                    fontweight: FontWeight.bold,
                    fontcolor: Colors.black87,
                  ),
                  columns: const [
                    DataColumn(label: Text('م')),
                    DataColumn(label: Text('اسم القسم')),
                    DataColumn(label: Center(child: Text('إجراءات'))),
                  ],
                  rows: controller.departments.map((dep) {
                    final index = controller.departments.indexOf(dep) + 1;
                    return DataRow(
                      cells: [
                        DataCell(Text(index.toString())),
                        DataCell(
                          Text(
                            dep.name,
                            style: cairoStyle(fontweight: FontWeight.w600),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "تأكيد الحذف",
                                  titleStyle: cairoStyle(
                                    fontSize: 18,
                                    fontweight: FontWeight.bold,
                                  ),
                                  middleText:
                                      "هل أنت متأكد من رغبتك في حذف قسم  ${dep.name} قد يترتب حذف الموظفين في هذا القسم؟",
                                  middleTextStyle: cairoStyle(fontSize: 16),
                                  textConfirm: "حذف",
                                  textCancel: "إلغاء",

                                  confirmTextColor: Colors.white,

                                  buttonColor: Colors.redAccent,
                                  onConfirm: () {
                                    Get.back();
                                    controller.deleteDepartment(
                                      dep.id!,
                                      context,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addDepartment);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
