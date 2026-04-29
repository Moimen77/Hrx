// ignore_for_file: non_constant_identifier_names

import 'package:hrx/data/models/Leaves_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveService {
  final supabase = Supabase.instance.client;

  Future<List<LeaveModel>> getLeaves({
    String search = "",
    String statusFilter = "الكل",
    DateTime? fromDate,
    DateTime? toDate,
    int offset = 0,
    int limit = 10,
  }) async {
    var query = supabase.from('leaveView').select();

    // فلتر الحالة
    if (statusFilter != "الكل") {
      query = query.eq('status', statusFilter);
    }

    // فلتر البحث بالاسم
    if (search.isNotEmpty) {
      query = query.ilike('employee_name', '%$search%');
    }

    // فلترة بالتواريخ
    if (fromDate != null) {
      query = query.gte('start_date', fromDate.toIso8601String());
    }

    if (toDate != null) {
      query = query.lte('end_date', toDate.toIso8601String());
    }

    final response = await query.range(offset, offset + limit - 1);

    return (response as List).map((e) => LeaveModel.fromJson(e)).toList();
  }

  Future<void> addLeave(Map<String, dynamic> data) async {
    await supabase.from('Leaves').insert(data);
    if (data['status'] == 'مقبولة') {
      deduct_leave_days(data);
    }
  }

  Future<void> updateLeaveStatus(
    int id,
    String status,
    String? hrDecision,
  ) async {
    await supabase
        .from('Leaves')
        .update({'status': status, 'hr_decision': hrDecision})
        .eq('id', id);
  }

  Future<int?> deduct_leave_days(Map<String, dynamic> data) async {
    final res = await supabase.rpc(
      'deduct_leave_days',
      params: {
        'p_employee_id': data['employee_id'],
        'p_leave_type': data['type'] == 'عارضة' ? 'casual' : 'annual',
        'p_start_date': DateTime.parse(data['start_date']).toIso8601String(),
        'p_end_date': DateTime.parse(data['end_date']).toIso8601String(),
      },
    );
    return res;
  }
}
