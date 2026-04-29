import 'package:hrx/data/models/LoanModel.dart';
import 'package:hrx/modules/hr/Loans/services/LoansServices.dart';

class AdvanceArchiveRepo {
  final AdvanceArchiveService _service;

  AdvanceArchiveRepo(this._service);

  Future<List<AdvanceModel>> fetchAdvances() async {
    final response = await _service.fetchAdvancesForEmployee();
    if (response != null && response is List) {
      return response.map((json) => AdvanceModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> updateLoanStatus(
    int id,
    String status,
    double? approvedAmount,
  ) async {
    await _service.updateLoanStatus(id, status, approvedAmount);
  }
}
