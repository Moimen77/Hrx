import 'package:hrx/modules/hr/HomeScreenHr/Employees/Repository/raise_repository.dart';

class RaiseService {
  final IRaiseRepository _raiseRepository = RaiseRepository();

  Future<void> createEmployeeRaise({
    required int employeeId,
    required double amount,
    required DateTime effectiveDate,
  }) async {
    await _raiseRepository.addRaise(
      employeeId: employeeId,
      amount: amount,
      effectiveDate: effectiveDate,
    );
  }
}
