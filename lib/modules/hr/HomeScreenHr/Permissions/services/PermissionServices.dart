// ignore_for_file: file_names

import 'package:supabase_flutter/supabase_flutter.dart';

class PermissionServices {
  final client = Supabase.instance.client;
  Future<List<dynamic>> getPermissions() async {
    final response = await client.from('permissions_view').select();

    return List<dynamic>.from(response);
  }

  Future<void> updatePermissionStatus(int id, bool status) async {
    await client
        .from('Permissions')
        .update({'hr_approve': status})
        .eq('id', id);
  }

  Future<void> deduct_perrmission(int employeeId) async {
    await client.rpc('consume_permission', params: {'emp_id': employeeId});
  }
}
