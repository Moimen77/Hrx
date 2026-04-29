import 'package:hrx/data/models/Perrmission_Model.dart';
import 'package:hrx/modules/Employee/substitute/services/SubtitutePermissionServices.dart';

class Subtitutepermissionrepo {
  SubtitutePermissionServices services;
  Subtitutepermissionrepo(this.services);
  Future<List<PerrmissionModel>> fetchSubstitutePermissions(
    int departmentId,
    int currentEmployeeId,
  ) async {
    final permissions = await services.fetchSubstitutePermissions(
      departmentId,
      currentEmployeeId,
    );
    return permissions.map((e) => PerrmissionModel.fromJson(e)).toList();
  }
}
