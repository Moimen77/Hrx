class AttendanceFilter {
  DateTime? fromDate;
  DateTime? toDate;
  String? fromTime; // HH:mm
  String? toTime; // HH:mm
  String? branchId;
  String? shiftId;
  String? status;
  AttendanceFilter({
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.branchId,
    this.shiftId,
  });
}
