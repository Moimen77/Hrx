import 'package:hrx/data/models/AttendanceFilter.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/AttendanceArchive_Services.dart';

class AttendanceRepository {
  final AttendanceService service;

  AttendanceRepository(this.service);

  Future<List<EmployeeDayModel>> getAttendance({
    required int employeeId,
    required AttendanceFilter filter,
  }) async {
    final data = await service.fetchAttendance(
      employeeId: employeeId,
      filter: filter,
    );

    return data.map((e) => EmployeeDayModel.fromJson(e)).toList();
  }

  Future<List<BranchModel>> getBranches() async {
    final data = await service.getBranches();
    return data.map((e) => BranchModel.fromMap(e)).toList();
  }
}
