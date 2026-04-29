import 'package:get/get.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/LeaveBalanceModel.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/repo/employee_leaves_repo.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';

class EmployeeLeavesController extends GetxController with NetworkAwareMixin {
  final EmployeeLeavesRepository repo;
  EmployeeLeavesController(this.repo);

  RxList<LeaveModel> myLeaves = <LeaveModel>[].obs;
  Rxn<EmployeeLeaveBalance> leaveBalances = Rxn<EmployeeLeaveBalance>();
  late int employeeId;
  RxInt reponseCounter = 0.obs;
  Homepagecontroller homeController = Get.find<Homepagecontroller>();
  late DateTime appoimentdate;
  RxBool isLoading = false.obs;
  bool ismanger = false;

  @override
  void onInit() {
    super.onInit();
    final employee = homeController.Employee;

    if (employee != null && employee.appointmentDate != null) {
      appoimentdate = employee.appointmentDate!;
      employeeId = homeController.Employee?.id ?? 0;
      ismanger = homeController.Employee?.isManger ?? false;
    }
    fetchAllData();
  }

  fetchAllData() async {
    try {
      isLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      await Future.wait([
        fetchLeaveBalances(),
        fetchResponseCounter(),
        fetchMyLeaves(),
      ]);
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء تحميل البيانات');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeaveBalances() async {
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      leaveBalances.value = await repo.getEmployeeLeaveBalance(employeeId);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchResponseCounter() async {
    final hasInternet = await ensureInternetConnection(showMessage: false);
    if (!hasInternet) {
      return;
    }
    final countResult = await repo.getResponseCounter(
      employeeId,
      homeController.Employee?.departmentId ?? 0,
    );

    reponseCounter.value = countResult;
  }

  Future<void> fetchMyLeaves() async {
    try {
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      if (Get.isRegistered<Homepagecontroller>()) {
        final homeController = Get.find<Homepagecontroller>();
        final employeeId = homeController.Employee?.id;
        ismanger = homeController.Employee?.isManger ?? false;

        if (employeeId != null) {
          myLeaves.value = await repo.getMyLeaves(employeeId);
        } else {
          Get.snackbar('تنبيه', 'لم يتم العثور على بيانات الموظف');
        }
      } else {
        Get.snackbar('خطأ', 'حدث خطأ في استرجاع بيانات المستخدم');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل الإجازات: $e');
    }
  }
}
