import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/Employee/Loans/AdvanceArchiveService.dart';

class AdvanceArchiveRepo {
  final AdvanceArchiveService _service;

  AdvanceArchiveRepo(this._service);

  Future<List<AdvanceModel>> fetchAdvances(int employeeId) async {
    final response = await _service.fetchAdvancesForEmployee(employeeId);
    if (response != null && response is List) {
      return response.map((json) => AdvanceModel.fromJson(json)).toList();
    }
    return [];
  }
}
