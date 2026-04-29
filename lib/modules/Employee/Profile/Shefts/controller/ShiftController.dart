import 'package:get/get.dart';
import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:hrx/modules/Employee/Profile/Shefts/repo/Sheft_Repo.dart';

class ShiftController extends GetxController {
  final ShiftRepo repo;

  ShiftController(this.repo);

  RxList<ShiftModel> shifts = <ShiftModel>[].obs;
  RxString activeSeason = ''.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    try {
      isloading.value = true;
      shifts.value = await repo.getAll();
      activeSeason.value = await repo.activeSeason() ?? "";
    } catch (e) {
      print(e);
    } finally {
      isloading.value = false;
    }
  }

  Future<void> setSeason(String season) async {
    await repo.activate(season);
    await loadData();
  }
}
