// f:\Flutter\hrx_employees\lib\modules\Substitute\repo\SubstituteRepo.dart

import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/substitute/services/SubstituteServices.dart';

class SubstituteRepository {
  final SubstituteService service;

  SubstituteRepository(this.service);

  Future<List<LeaveModel>> getSubstituteLeaves(
    int departmentId,
    int currentEmployeeId,
  ) async {
    final data = await service.getSubstituteLeaves(
      departmentId,
      currentEmployeeId,
    );

    return data.map((e) => LeaveModel.fromJson(e)).toList();
  }

  Future<void> acceptAsSubstitute(
    int leaveId,
    int substituteId,
    String substituteName,
  ) async {
    await service.acceptAsSubstitute(leaveId, substituteId, substituteName);
  }
}
