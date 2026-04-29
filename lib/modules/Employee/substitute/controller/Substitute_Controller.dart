// f:\Flutter\hrx_employees\lib\modules\Substitute\controller\SubstituteController.dart
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/substitute/repo/Substitute_repo.dart';
import 'package:hrx/modules/Employee/substitute/repo/SubtitutePermissionRepo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubstituteController extends GetxController with NetworkAwareMixin {
  final SubstituteRepository leave_repo;
  Subtitutepermissionrepo permission_repo;
  SubstituteController(this.permission_repo, this.leave_repo);

  Myservices myServices = Get.find();
  late Homepagecontroller homeController;

  RxList<LeaveModel> substituteLeaves = <LeaveModel>[].obs;
  RxList<PerrmissionModel> substitutePermissions = <PerrmissionModel>[].obs;
  late int currentEmployeeId;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // الحصول على controller الصفحة الرئيسية للوصول لبيانات الموظف الحالي
    homeController = Get.find<Homepagecontroller>();
    currentEmployeeId = homeController.Employee?.id ?? 0;
    fetchSubstituteLeaves();
    fetchSubstitutePermissions();
    super.onInit();
  }

  bool isMe(int? substitute_employee_id) {
    return substitute_employee_id == currentEmployeeId;
  }

  Future<void> fetchSubstituteLeaves() async {
    isLoading.value = true;
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final departmentIdString = myServices.sharedPref.getString(
        'department_id',
      );

      if (departmentIdString != null) {
        final departmentId = int.parse(departmentIdString);
        substituteLeaves.value = await leave_repo.getSubstituteLeaves(
          departmentId,
          currentEmployeeId,
        );
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل البيانات: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubstitutePermissions() async {
    try {
      isLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final departmentIdString = myServices.sharedPref.getString(
        'department_id',
      );
      final currentEmployeeId = homeController.Employee?.id;

      if (departmentIdString != null && currentEmployeeId != null) {
        final departmentId = int.parse(departmentIdString);
        substitutePermissions.value = await permission_repo
            .fetchSubstitutePermissions(departmentId, currentEmployeeId);
      }
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء تحميل البيانات');
    }
  }

  Future<void> acceptAsSubstitute(LeaveModel leave) async {
    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد القبول'),
        content: Text(
          'هل أنت متأكد من قبولك كبديل للموظف ${leave.employeeName} في فترة إجازته؟',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              isLoading.value = true;
              try {
                if (!await ensureInternetConnection()) {
                  return;
                }
                final currentEmployee = homeController.Employee;
                if (currentEmployee?.id == null ||
                    currentEmployee?.name == null) {
                  Get.snackbar('خطأ', 'لا يمكن تحديد الموظف الحالي.');
                  return;
                }
                await leave_repo.acceptAsSubstitute(
                  leave.id!,
                  currentEmployee!.id!,
                  currentEmployee.name!,
                );
                // إرسال إشعار للموظف صاحب الطلب
                await FCMService().sendNotification(
                  topic: leave.employeeId.toString(),
                  title: 'تم قبول طلب البديل',
                  body:
                      '${currentEmployee.name} وافق/ت على أن يكون البديل في فترة إجازتك.',
                );
                Get.snackbar('تم', 'لقد وافقت على أن تكون البديل.');
              } catch (e) {
                Get.snackbar('خطأ', 'فشل قبول الطلب: ${e.toString()}');
              } finally {
                await fetchSubstituteLeaves();
              }
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  Future<void> acceptPermissionSubstitute(
    int permissionId,
    String employeeName,
    int employeeId,
  ) async {
    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد القبول'),
        content: Text(
          'هل أنت متأكد من قبولك كبديل للموظف $employeeName في هذا الإذن؟',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              isLoading.value = true;
              try {
                if (!await ensureInternetConnection()) {
                  return;
                }
                final currentEmployee = homeController.Employee;
                if (currentEmployee?.id == null) return;

                final supabase = Supabase.instance.client;
                await supabase
                    .from('Permissions')
                    .update({'sub_employee': currentEmployee!.id})
                    .eq('id', permissionId);

                await FCMService().sendNotification(
                  topic: employeeId.toString(),
                  title: 'تم قبول طلب البديل للإذن',
                  body:
                      '${currentEmployee.name} وافق/ت على أن يكون البديل للإذن الخاص بك.',
                );
                Get.snackbar('تم', 'لقد وافقت على أن تكون البديل.');
              } catch (e) {
                Get.snackbar('خطأ', 'فشل قبول الطلب: ${e.toString()}');
              } finally {
                isLoading.value = false;
                await fetchSubstitutePermissions();
              }
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
