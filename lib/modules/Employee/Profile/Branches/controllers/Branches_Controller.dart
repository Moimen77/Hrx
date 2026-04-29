import 'package:get/get.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/modules/Employee/Profile/Branches/repo/Branches_Repo.dart';

class BranchesController extends GetxController {
  final BranchesRepository repo;
  BranchesController(this.repo);

  RxList<BranchModel> branches = <BranchModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBranches();
    super.onInit();
  }

  Future<void> fetchBranches() async {
    isLoading.value = true;
    branches.value = await repo.getBranches();
    isLoading.value = false;
  }

  Future<void> addBranch(BranchModel branch) async {
    await repo.addBranch(branch);
    fetchBranches();
  }

  Future<void> deleteBranch(int id) async {
    await repo.deleteBranch(id);
    fetchBranches();
  }
}
