import 'package:hrx/data/models/departmentmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DepartmentService {
  final supabase = Supabase.instance.client;

  Future<List<DepartmentModel>> getDepartments() async {
    final response = await supabase.from("departments").select();
    print('this response is $response');
    return response.map((e) => DepartmentModel.fromJson(e)).toList();
  }

  Future<void> addDepartment(DepartmentModel department) async {
    await supabase.from("departments").insert(department.toJson());
  }

  Future<void> updateDepartment(DepartmentModel department) async {
    await supabase
        .from("departments")
        .update(department.toJson())
        .eq("id", department.id!);
  }

  Future<void> deleteDepartment(int id) async {
    await supabase.from("departments").delete().eq("id", id);
  }
}
