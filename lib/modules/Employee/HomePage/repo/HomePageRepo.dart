// ignore_for_file: non_constant_identifier_names

import 'package:hrx/data/models/EmployeeModel.dart';
import 'package:hrx/data/models/activityModel.dart';
import 'package:hrx/data/models/employeeDayModel.dart';
import 'package:hrx/modules/Employee/HomePage/services/HomePageServices.dart';

class Homepagerepo {
  Homepagerepo(this.homepageServices);
  final HomepageServices homepageServices;

  Future<List<EmployeeModel>> GetProfileData() async {
    final res = await homepageServices.getEmployeeProfileData();
    final List<EmployeeModel> Employees = res
        .map((e) => EmployeeModel.fromMap(e))
        .toList();

    return Employees;
  }

  Future<int> getPageCount(int emp_id, int department_id) async {
    final count = await homepageServices.getPageCount(emp_id, department_id);
    return count;
  }

  Future<List<EmployeeDayModel>> GetTodayAttendance(int empid) async {
    final res = await homepageServices.GetAttendaceToday(empid);
    final List<EmployeeDayModel> attendance = res
        .map((e) => EmployeeDayModel.fromJson(e))
        .toList();

    return attendance;
  }

  Future<void> CheckOut(int employeeId) async {
    try {
      await homepageServices.CheckOut(employeeId);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<ActivityLogModel>> getRecentActivities(int employeeId) async {
    final response = await homepageServices.getRecentActivities(employeeId);
    print('repo');
    return response.map((e) => ActivityLogModel.fromJson(e)).toList();
  }
}
