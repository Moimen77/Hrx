import 'package:get/get.dart';
import 'package:hrx/core/class/AttendanceMode.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Department/controller/department_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService {
  final supabase = Supabase.instance.client;
  final departments = Get.find<DepartmentController>().departments;

  String getdepartmentName(int id) {
    String departmentName = departments
        .firstWhere((element) => element.id == id)
        .name;
    return departmentName;
  }

  Future<List<EmployeeDayModel>> getAttendance({
    required String date,
    required String departmentName,
    String search = "",
  }) async {
    final res = await supabase.rpc(
      'employee_attendance_table',
      params: {
        'p_start_date': date,
        'p_end_date': date,
        'p_employee_id': null, // كل الموظفين
      },
    );

    List data = res as List;

    // ✅ فلترة القسم
    if (departmentName != "الكل") {
      data = data.where((e) => e['department_name'] == departmentName).toList();
    }

    // ✅ فلترة البحث
    if (search.isNotEmpty) {
      data = data
          .where(
            (e) => (e['employeename'] ?? "").toString().toLowerCase().contains(
              search.toLowerCase(),
            ),
          )
          .toList();
    }

    return data.map((e) => EmployeeDayModel.fromJson(e)).toList();
  }

  // Manual Check-in
  Future<void> manualCheckIn(
    int employeeId,
    DateTime checkInTime,
    String? latePenaltyType, [
    bool isPermission = false,
  ]) async {
    await supabase.from("Attendance").insert({
      "employee_id": employeeId,
      "check_in": checkInTime.toIso8601String(),
      'permission_minute': isPermission ? 120 : null,
      'attend_date': checkInTime.toIso8601String(),
      'late_penalty_type': latePenaltyType,
      "status": latePenaltyType != null ? "late" : "present",
    });
  }

  Future<bool> isAlreadyChecked(
    int employeeId,
    DateTime checkInTime,
    Attendancemode mode,
  ) async {
    final today = DateTime(
      checkInTime.year,
      checkInTime.month,
      checkInTime.day,
    );
    String checktype = !(mode == Attendancemode.checkIn)
        ? "check_out"
        : "check_in";

    // 2. نبحث هل الموظف سجّل النهارده
    final existing = await supabase
        .from("Attendance")
        .select()
        .eq("employee_id", employeeId)
        .gte(checktype, today.toIso8601String())
        .lt(checktype, today.add(const Duration(days: 1)).toIso8601String())
        .maybeSingle();

    if (existing != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> manualCheckOut(int employeeId, DateTime checkoutTime) async {
    // 1️⃣ هات آخر سجل حضور للموظف لسه مفيهوش check_out
    final attendance = await supabase
        .from("Attendance")
        .select()
        .eq("employee_id", employeeId)
        .isFilter("check_out", null) // السطر الصحيح
        .order("created_at", ascending: false)
        .limit(1)
        .maybeSingle();

    if (attendance == null) {
      throw Exception("no_open_attendance");
    }

    final int attendanceId = attendance["id"] as int;

    // 3️⃣ تحديث وقت الانصراف
    await supabase
        .from("Attendance")
        .update({"check_out": checkoutTime.toIso8601String()})
        .eq("id", attendanceId);
  }

  Future<List<EmployeeDayModel>> getEmployeeDays(
    int employeeId,
    DateTime from,
    DateTime to,
  ) async {
    final res = await supabase.rpc(
      'employee_attendance_table',
      params: {
        'p_employee_id': employeeId,
        'p_start_date': from.toIso8601String(),
        'p_end_date': to.toIso8601String(),
      },
    );

    return (res as List).map((e) => EmployeeDayModel.fromJson(e)).toList();
  }
}
