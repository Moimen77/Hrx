import 'package:get/get.dart';
import 'package:hrx/core/mixin/network_aware_mixin.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveRepo.dart';

class AdvanceArchiveController extends GetxController with NetworkAwareMixin {
  final AdvanceArchiveRepo repo;
  AdvanceArchiveController(this.repo);

  final Myservices _services = Get.find();
  final RxBool isLoading = true.obs;
  final RxList<AdvanceModel> advances = <AdvanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserAdvances();
  }

  Future<void> fetchUserAdvances() async {
    try {
      isLoading.value = true;
      final hasInternet = await ensureInternetConnection(showMessage: false);
      if (!hasInternet) {
        return;
      }
      final employeeId = int.parse(_services.sharedPref.getString('id') ?? '0');
      final result = await repo.fetchAdvances(employeeId);
      advances.assignAll(result);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تحميل سجل السلف');
    } finally {
      isLoading.value = false;
    }
  }
}
