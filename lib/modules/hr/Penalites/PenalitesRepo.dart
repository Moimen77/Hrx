import 'package:hrx/data/models/PenalitesModel.dart';
import 'package:hrx/modules/hr/Penalites/PenalitesServices.dart';

class PenaltyRepository {
  final PenaltyService service;

  PenaltyRepository(this.service);

  Future<List<PenaltyModel>> fetchPenalties() {
    return service.getPenalties();
  }

  Future<void> createPenalty({
    required int employeeId,
    required String type,
    required String reason,
    required double amountDay,
    required bool isRival,
    required DateTime penaltyDate,
  }) {
    return service.addPenalty({
      'employee_id': employeeId,
      'type': type,
      'reason': reason,
      'amount_day': amountDay,
      'is_rival': isRival,
      'penalty_date': penaltyDate.toIso8601String(),
    });
  }

  Future<void> updatePenaltyAmount(int id, double amount) {
    return service.updatePenalty(id, {'amount_day': amount});
  }

  Future<void> cancelPenalty(int id) {
    return service.updatePenalty(id, {'status': 'cancel'});
  }

  Future<void> removePenalty(int id) {
    return service.deletePenalty(id);
  }
}
