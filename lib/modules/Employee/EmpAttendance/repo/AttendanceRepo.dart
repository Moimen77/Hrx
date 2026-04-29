import 'package:hrx/core/function/CustomSnackPar.dart';
import 'package:hrx/data/models/BranchesModel.dart';
import 'package:hrx/data/models/ShiftsModel.dart';
import 'package:hrx/modules/Employee/EmpAttendance/services/Attendance_services.dart';

class Attendancerepo {
  final AttendanceServices attendanceServices;
  Attendancerepo({required this.attendanceServices});

  Future<List<BranchModel>> getBranches() async {
    try {
      final res = await attendanceServices.getBranches();
      return res.map((e) => BranchModel.fromMap(e)).toList();
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء جلب المعلومات');
    }
    return [];
  }

  Future<List<ShiftModel>> getShifts(String empType) async {
    try {
      final res = await attendanceServices.getShifts(empType);
      return res.map((e) => ShiftModel.fromJson(e)).toList();
    } catch (e) {
      AppSnack.error('حدث خطأ', 'حدث خطأ أثناء جلب المعلومات');
      rethrow;
    }
  }

  Future<void> checkIn(int employeeId, int branchId, int shiftId) async {
    try {
      await attendanceServices.checkIn(employeeId, branchId, shiftId);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
