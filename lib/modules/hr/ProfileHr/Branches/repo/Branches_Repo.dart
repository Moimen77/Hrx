import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/services/Branches_servicesSupabase.dart';

class BranchesRepository {
  final BranchesSupabaseService service;
  BranchesRepository(this.service);

  Future<List<BranchModel>> getBranches() async {
    final data = await service.getBranches();
    return data.map((e) => BranchModel.fromMap(e)).toList();
  }

  Future<void> addBranch(BranchModel branch) async {
    await service.insertBranch(branch.toMap());
  }

  Future<void> deleteBranch(int id) async {
    await service.deleteBranch(id);
  }

  Future<void> updateBranch(int id, BranchModel branch) async {
    await service.updateBranch(id, branch.toMap());
  }
}
