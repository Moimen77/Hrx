import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getEmployeeProfileData() async {
    String uid = _client.auth.currentUser!.id;
    final res = await _client
        .from('employees_view')
        .select()
        .eq('user_id', uid);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<void> updateProfileImage(
    String fileName,
    File file,
    int employeeId,
  ) async {
    final oldData = await _client
        .from('Employees')
        .select('profile_image')
        .eq('id', employeeId)
        .single();

    final oldImagePath = oldData['profile_image'];

    if (oldImagePath != null && oldImagePath.toString().isNotEmpty) {
      final uri = Uri.parse(oldImagePath);
      final oldFileName = uri.pathSegments.last;
      await _client.storage.from('employee-images').remove([oldFileName]);
    }
    await _client.storage.from('employee-images').upload(fileName, file);
    final imageUrl = _client.storage
        .from('employee-images')
        .getPublicUrl(fileName);
    await _client
        .from('Employees')
        .update({'profile_image': imageUrl})
        .eq('id', employeeId);
  }
}
