import 'package:get/get.dart';
import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/EmployeeTypeModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/repo/Sheft_Repo.dart';

class ShiftController extends GetxController {
  final ShiftRepo repo;

  ShiftController(this.repo);

  var isLoading = true.obs;
  var employeeTypes = <EmployeeTypeModel>[].obs;

  @override
  void onInit() {
    fetchShifts();
    super.onInit();
  }

  Future<void> fetchShifts() async {
    try {
      isLoading.value = true;
      final data = await repo.fetchData();
      employeeTypes.value = data;
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء جلب البيانات من الخادم');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateShift({
    required int shiftId,
    required String name,
    required String startTime,
    required String endTime,
  }) async {
    try {
      isLoading.value = true;

      await repo.updateShift(
        shiftId: shiftId,
        name: name,
        startTime: startTime,
        endTime: endTime,
      );
      AppSnack.success("تم بنجاح", "تم تعديل الشيفت بنجاح");
      await fetchShifts();
    } catch (e) {
      AppSnack.error("حدث خطأ", "حدث خطأ أثناء تعديل الشيفت");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
