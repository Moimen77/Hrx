// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class Hrdataservices {
  final client = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> GetprofileData() async {
    String hrID = client.auth.currentUser!.id;
    print(hrID);
    final res = await client.from('Hrs').select().eq('user_id', hrID);
    return res;
  }

  Future<void> updateProfileImage(String fileName, File file, int hrId) async {
    final oldData = await client
        .from('Hrs')
        .select('image')
        .eq('id', hrId)
        .single();

    final oldImagePath = oldData['image'];
    final uri = Uri.parse(oldImagePath);
    final oldFileName = uri.pathSegments.last;

    if (oldImagePath != null && oldImagePath.toString().isNotEmpty) {
      await client.storage.from('employee-images').remove([oldFileName]);
    }
    await client.storage.from('employee-images').upload(fileName, file);
    final imageUrl = client.storage
        .from('employee-images')
        .getPublicUrl(fileName);
    await client.from('Hrs').update({'image': imageUrl}).eq('id', hrId);
  }
}
