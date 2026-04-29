import 'package:hrx/data/models/LeaveBalanceModel.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/EmployeeLeaves.dart/services/employee_leaves_service.dart';
import 'package:hrx/modules/Employee/LeaveBalance/services/LeaveBalanceServices.dart';

class EmployeeLeavesRepository {
  final EmployeeLeavesService service;
  final LeaveBalanceService leaveBalanceService;

  EmployeeLeavesRepository(this.service, this.leaveBalanceService);

  Future<List<LeaveModel>> getMyLeaves(int employeeId) async {
    final data = await service.getMyLeaves(employeeId);
    return data.map((e) => LeaveModel.fromJson(e)).toList();
  }

  Future<int> getResponseCounter(int departmentId, int employeeId) async {
    final count = await service.getPageCount(employeeId, departmentId);
    return count;
  }

  Future<EmployeeLeaveBalance> getEmployeeLeaveBalance(int employeeId) async {
    final data = await leaveBalanceService.getEmployeeLeaveBalance(employeeId);
    return EmployeeLeaveBalance.fromJson(data);
  }
}
