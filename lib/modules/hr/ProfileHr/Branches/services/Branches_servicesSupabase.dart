import 'package:supabase_flutter/supabase_flutter.dart';

class BranchesSupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getBranches() async {
    return await supabase.from("branches").select();
  }

  Future<void> insertBranch(Map<String, dynamic> data) async {
    await supabase.from("branches").insert(data);
  }

  Future<void> deleteBranch(int id) async {
    await supabase.from("branches").delete().eq("id", id);
  }

  Future<void> updateBranch(int id, Map<String, dynamic> data) async {
    await supabase.from("branches").update(data).eq("id", id);
  }
}
