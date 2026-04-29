import 'package:hrx/data/models/BonusModel.dart';
import 'package:hrx/modules/hr/Bonuses/BonusServices.dart';

class BonusRepository {
  final BonusService service;

  BonusRepository(this.service);

  Future<List<BonusModel>> fetchBonuses() {
    return service.getBonuses();
  }

  Future<void> editBonus(int id, Map<String, dynamic> data) {
    return service.updateBonus(id, data);
  }
}
