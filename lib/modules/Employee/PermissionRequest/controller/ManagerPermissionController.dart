import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Permissions/controller/Permission_Controller.dart';
import 'package:hrx/modules/FCM_notification/Services/fcm_service.dart';
import '../repo/ManagerPermissionRepo.dart';

class ManagerPermissionController extends GetxController with NetworkAwareMixin {
  final ManagerPermissionRepo repo;
  ManagerPermissionController(this.repo);

  Myservices myServices = Get.find();
  late Homepagecontroller homeController;

  RxList<PerrmissionModel> permissionsList = <PerrmissionModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    homeController = Get.find<Homepagecontroller>();
    fetchPermissions();
    super.onInit();
  }

  // جلب البيانات
  Future<void> fetchPermissions() async {
    isLoading.value = true;
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final departmentIdString = myServices.sharedPref.getString(
        'department_id',
      );
      final currentEmployeeId = homeController.Employee?.id.toString();

      if (departmentIdString != null && currentEmployeeId != null) {
        final departmentId = int.parse(departmentIdString);

        permissionsList.value = await repo.getDepartmentPermissions(
          departmentId,
          currentEmployeeId,
        );
      } else {
        AppSnack.error('تنبيه', 'لم يتم العثور على بيانات القسم أو الموظف');
      }
    } catch (e) {
      AppSnack.error('خطأ', 'فشل تحميل الطلبات: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // دالة لاتخاذ إجراء (قبول أو رفض)
  Future<void> actionPermission(
    PerrmissionModel permission,
    bool isAccepted,
  ) async {
    String status = isAccepted ? 'approved' : 'rejected';
    String actionText = isAccepted ? 'قبول' : 'رفض';
    isLoading.value = true;
    try {
      if (!await ensureInternetConnection()) {
        return;
      }
      if (permission.id != null) {
        await repo.updatePermissionStatus(
          permission.id!,
          status == 'approved' ? true : false,
        );
        Get.snackbar('نجاح', 'تم $actionText الطلب بنجاح');
        FCMService fcmService = FCMService();
        await fcmService.sendNotification(
          title: 'رد طلب الإذن',
          body: '$actionText المدير طلب إذنك',
          topic: permission.employeeId.toString(),
        );
        await Get.find<PermissionController>().fetchPermissionsRequestsCount();
        await fetchPermissions();
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء العملية: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
