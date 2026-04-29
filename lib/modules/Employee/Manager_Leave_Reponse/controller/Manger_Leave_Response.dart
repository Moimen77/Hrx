// f:\Flutter\hrx_employees\lib\modules\ManagerLeaves\controller\ManagerLeavesController.dart

import 'package:get/get.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/controller/employee_leaves_controller.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/repo/Manger_reponse_repo.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';

class ManagerLeavesController extends GetxController with NetworkAwareMixin {
  final ManagerLeavesRepository repo;
  ManagerLeavesController(this.repo);

  RxList<LeaveModel> pendingLeaves = <LeaveModel>[].obs;
  RxBool isLoading = false.obs;

  Myservices myServices = Get.find();
  late Homepagecontroller homeController;

  @override
  void onInit() {
    homeController = Get.find<Homepagecontroller>();
    fetchPendingLeaves();
    super.onInit();
  }

  Future<void> fetchPendingLeaves() async {
    isLoading.value = true;
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final deptIdStr = myServices.sharedPref.getString('department_id');
      final currentEmpId = homeController.Employee?.id;

      if (deptIdStr != null && currentEmpId != null) {
        final deptId = int.parse(deptIdStr);
        pendingLeaves.value = await repo.getPendingLeaves(deptId, currentEmpId);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل الطلبات: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatus(LeaveModel leave, String status) async {
    try {
      isLoading.value = true;
      if (!await ensureInternetConnection()) {
        return;
      }
      await repo.updateLeaveStatus(leave.id!, status);
      pendingLeaves.remove(leave);
      FCMService fcmService = FCMService();
      await fcmService.sendNotification(
        title: 'رد المدير',
        body: 'تم ${status == "مقبولة" ? "قبول" : "رفض"} طلبك للاجازة',
        topic: leave.employeeId.toString(),
      );
      Get.snackbar(
        'نجاح',
        'تم ${status == "مقبولة" ? "قبول" : "رفض"} الطلب بنجاح',
      );
      await Get.find<EmployeeLeavesController>().fetchResponseCounter();
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء التحديث: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
