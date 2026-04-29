import 'package:hrx/data/models/EmployeeTypeModel.dart';
import 'package:hrx/modules/hr/ProfileHr/Shefts/services/shefts_Services.dart';

class ShiftRepo {
  final ShiftService service;

  ShiftRepo(this.service);

  Future<List<EmployeeTypeModel>> fetchData() {
    return service.getEmployeeTypesWithShifts();
  }

  Future<void> updateShift({
    required int shiftId,
    required String name,
    required String startTime,
    required String endTime,
  }) {
    return service.updateShift(
      shiftId: shiftId,
      name: name,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
