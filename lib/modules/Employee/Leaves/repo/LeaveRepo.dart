import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/LeaveBalanceModel.dart';
import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/Employee/LeaveBalance/services/LeaveBalanceServices.dart';
import 'package:hrx/modules/Employee/Leaves/services/LeaveServices.dart';

class LeaveRepository {
  final LeaveService service;
  final LeaveBalanceService balanceService;

  LeaveRepository(this.service, this.balanceService);

  Future<void> requestLeave(LeaveModel leave) {
    return service.requestLeave(leave);
  }

  Future<List<EmployeeModel>> getManagers() async {
    final data = await service.getManagers();
    return data.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  Future<int> calculateWorkingDays({
    required DateTime startDate,
    required DateTime endDate,
    required int employeeId,
  }) async {
    return service.calculateWorkingDays(
      startDate: startDate,
      endDate: endDate,
      employeeId: employeeId,
    );
  }

  Future<List<EmployeeModel>> getDepartmentEmployees(int departmentId) async {
    final data = await service.getDepartmentEmployees(departmentId);
    return data.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  Future<EmployeeLeaveBalance> getEmployeeLeaveBalance(int employeeId) async {
    final data = await balanceService.getEmployeeLeaveBalance(employeeId);
    return EmployeeLeaveBalance.fromJson(data);
  }
}
