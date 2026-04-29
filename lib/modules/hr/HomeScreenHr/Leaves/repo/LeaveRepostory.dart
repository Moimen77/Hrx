import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/services/LeaveServices.dart';

class LeaveRepository {
  final LeaveService service;

  LeaveRepository({required this.service});

  Future<List<LeaveModel>> getLeaves({
    String search = "",
    String statusFilter = "الكل",
    DateTime? fromDate,
    DateTime? toDate,
    int offset = 0,
    int limit = 10,
  }) {
    return service.getLeaves(
      search: search,
      statusFilter: statusFilter,
      fromDate: fromDate,
      toDate: toDate,
      offset: offset,
      limit: limit,
    );
  }

  Future<void> addLeave(Map<String, dynamic> data) {
    return service.addLeave(data);
  }

  Future<void> updateLeaveStatus(int id, String status, String? hrDecision) {
    return service.updateLeaveStatus(id, status, hrDecision);
  }

  Future<int?> deduct_leave_days(Map<String, dynamic> data) {
    return service.deduct_leave_days(data);
  }
}
