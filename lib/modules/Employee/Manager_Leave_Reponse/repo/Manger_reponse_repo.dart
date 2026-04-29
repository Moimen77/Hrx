// f:\Flutter\hrx_employees\lib\modules\ManagerLeaves\repo\ManagerLeavesRepo.dart

import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/services/MangerLeavesServices.dart';

class ManagerLeavesRepository {
  final ManagerLeavesService service;
  ManagerLeavesRepository(this.service);

  Future<List<LeaveModel>> getPendingLeaves(
    int departmentId,
    int currentEmployeeId,
  ) async {
    try {
      final data = await service.getPendingLeaves(
        departmentId,
        currentEmployeeId,
      );

      return data.map((e) {
        final leave = LeaveModel.fromJson(e);
        return leave;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLeaveStatus(int leaveId, String status) async {
    await service.updateLeaveStatus(leaveId, status);
  }
}
