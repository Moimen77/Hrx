import 'package:get/get.dart';
import 'package:hrx/core/class/CheckInternetController.dart';
import 'package:hrx/core/function/DesignAlert.dart';
import 'package:hrx/data/models/departmentmodel.dart';
import '../services/department_service.dart';

class DepartmentController extends GetxController {
  final DepartmentService service = DepartmentService();
  RxBool isLoading = false.obs;
  RxList<DepartmentModel> departments = <DepartmentModel>[].obs;
  Rx<DepartmentModel?> selectedDepartment = Rx<DepartmentModel?>(null);
  final networkController = Get.find<NetworkController>();

  @override
  void onInit() {
    fetchDepartments();
    super.onInit();
  }

  Future<void> fetchDepartments() async {
    try {
      isLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      final data = await service.getDepartments();
      departments.value = data;
      isLoading.value = false;
      if (data.isNotEmpty) selectedDepartment.value = data.first;
    } catch (e) {
      print("❌ Departments Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDepartment(int id, context) async {
    try {
      isLoading.value = true;
      await service.deleteDepartment(id);
      departments.removeWhere((element) => element.id == id);
      isLoading.value = false;
    } catch (e) {
      showErrorDialog(context, 'حدث خطأ أثناء حذف القسم: $e');
    } finally {
      fetchDepartments();
    }
  }

  Future<void> AddDepartment(DepartmentModel department, context) async {
    try {
      await service.addDepartment(department);
    } catch (e) {
      showErrorDialog(context, 'حدث خطأ أثناء حذف القسم: $e');
    }
  }

  void changeDepartment(DepartmentModel department) {
    selectedDepartment.value = department;
  }
}
