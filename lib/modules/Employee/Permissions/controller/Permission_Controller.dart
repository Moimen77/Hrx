import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/modules/Employee/Permissions/repo/Permission_Repo.dart';

class PermissionController extends GetxController with NetworkAwareMixin {
  final PermissionRepo permissionRepo;
  PermissionController(this.permissionRepo);

  Myservices myServices = Get.find();
  Homepagecontroller homepagecontroller = Get.find();
  bool ismanager = false;
  RxInt padgeCount = 0.obs;

  var permissions = <PerrmissionModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    final employee = homepagecontroller.Employee;

    if (employee != null) {
      ismanager = employee.isManger ?? false;
      fetchPermissionsRequestsCount();
      fetchPermissions();
    }

    super.onInit();
  }

  Future<void> fetchPermissions() async {
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final employee = homepagecontroller.Employee;
      if (employee == null) return;
      int currentUserId = int.parse(myServices.sharedPref.getString('id')!);
      isLoading.value = true;
      final result = await permissionRepo.getPermissions(currentUserId);
      permissions.assignAll(result);
    } catch (e) {
      AppSnack.error('خطأ', 'حدث خطأ أثناء جلب الأذونات');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPermissionsRequestsCount() async {
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      int count = await permissionRepo.getPermissionsRequestsCount(
        int.parse(myServices.sharedPref.getString('id')!),
        homepagecontroller.Employee!.departmentId!,
      );
      padgeCount.value = count;
    } catch (e) {
      AppSnack.error('خطأ', 'حدث خطأ أثناء جلب الأذونات');
    }
  }
}
