import 'dart:io' show File;

import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/modules/Employee/Profile/controller/ProfileService.dart';

class ProfileRepository {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  Future<List<EmployeeModel>> getEmployeeProfileData() async {
    final res = await _profileService.getEmployeeProfileData();
    final List<EmployeeModel> employees = res
        .map((e) => EmployeeModel.fromMap(e))
        .toList();
    return employees;
  }

  Future<void> updateProfileImage(
    String fileName,
    File file,
    int employeeId,
  ) async {
    await _profileService.updateProfileImage(fileName, file, employeeId);
  }
}
