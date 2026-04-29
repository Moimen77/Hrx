import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:hrx/modules/Employee/Profile/Shefts/services/shefts_Services.dart';

class ShiftRepo {
  final ShiftService service;

  ShiftRepo(this.service);

  Future<List<ShiftModel>> getAll() => service.getShifts();

  Future<String?> activeSeason() => service.getActiveSeason();

  Future<void> activate(String seasonName) =>
      service.activateSeason(seasonName);
}
