import 'package:flutter/material.dart';
import 'package:hrx/core/function/Activity/ActivityEnum.dart';
import 'package:hrx/data/models/activityModel.dart';

Map<String, dynamic> getActivityData(
  ActivityLogModel log, {
  required bool isEmployee,
}) {
  final metadata = log.metadata;

  switch (log.type) {
    case ActivityType.createEmployee:
      return {
        "title": "تم إضافة موظف جديد",
        "description": metadata['employee_name'] ?? "",
        "icon": Icons.person_add,
        "color": Colors.green,
      };

    case ActivityType.addRaise:
      return {
        "title": "تم إضافة زيادة",
        "description": isEmployee
            ? "تم إضافة زيادة بقيمة ${metadata['amount']} جنيه"
            : "تم إضافة زيادة ${metadata['amount']} جنيه للموظف ${metadata['employee_name']}",
        "icon": Icons.attach_money,
        "color": Colors.orange,
      };

    case ActivityType.paySalary:
      return {
        "title": "تم تسليم الراتب",
        "description": isEmployee
            ? "تم استلام راتب شهر ${metadata['month']} بقيمة ${metadata['amount']} جنيه"
            : "تم تسليم راتب شهر ${metadata['month']} بقيمة ${metadata['amount']} جنيه للموظف ${metadata['employee_name']}",
        "icon": Icons.payments,
        "color": Colors.green,
      };

    case ActivityType.approvePermission:
      return {
        "title": "تم قبول الإذن",
        "description": isEmployee
            ? "تم قبول إذنك (${metadata['type']})"
            : "تم قبول إذن ${metadata['employee_name']} (${metadata['type']})",
        "icon": Icons.check_circle,
        "color": Colors.green,
      };
    case ActivityType.addPenalty:
      return {
        "title": "تم إضافة جزاء",
        "description": isEmployee
            ? "تم إضافة جزاء بقيمة ${metadata['amount']} ${!metadata['is_percentage'] ? 'جنيه' : 'يوم'}"
            : "تم إضافة جزاء ${metadata['amount']} ${!metadata['is_percentage'] ? 'جنيه' : 'يوم'} للموظف ${metadata['employee_name']}",
        "icon": Icons.remove_circle,
        "color": Colors.red,
      };

    case ActivityType.addBonus:
      return {
        "title": "تم إضافة مكافأة",
        "description": isEmployee
            ? "تم إضافة مكافأة بقيمة ${metadata['amount']} جنيه"
            : "تم إضافة مكافأة ${metadata['amount']} جنيه للموظف ${metadata['employee_name']}",
        "icon": Icons.add_circle,
        "color": Colors.green,
      };

    case ActivityType.rejectPermission:
      return {
        "title": "تم رفض الإذن",
        "description": isEmployee
            ? "تم رفض إذنك"
            : "تم رفض إذن ${metadata['employee_name']}",
        "icon": Icons.cancel,
        "color": Colors.red,
      };

    case ActivityType.approveLeave:
      return {
        "title": "تم قبول الأجازة",
        "description": isEmployee
            ? "تم قبول أجازتك"
            : "تم قبول أجازة ${metadata['employee_name']}",
        "icon": Icons.check_circle,
        "color": Colors.green,
      };

    case ActivityType.rejectLeave:
      return {
        "title": "تم رفض الأجازة",
        "description": isEmployee
            ? "تم رفض أجازتك - ${metadata['penalty'] ?? ''}"
            : "تم رفض أجازة ${metadata['employee_name']} - ${metadata['penalty'] ?? ''}",
        "icon": Icons.cancel,
        "color": Colors.red,
      };

    case ActivityType.requestAdvance:
      return {
        "title": "طلب سلفة",
        "description": isEmployee
            ? "طلبت سلفة بقيمة ${metadata['amount']} جنيه"
            : "${metadata['employee_name']} طلب سلفة بقيمة ${metadata['amount']} جنيه",
        "icon": Icons.request_page,
        "color": Colors.orange,
      };

    case ActivityType.approveAdvance:
      return {
        "title": "تمت الموافقة على السلفة",
        "description": isEmployee
            ? "تمت الموافقة على سلفتك بقيمة ${metadata['approved_amount']} جنيه"
            : "تمت الموافقة على سلفة ${metadata['name']} بقيمة ${metadata['approved_amount']} جنيه",
        "icon": Icons.verified,
        "color": Colors.blue,
      };

    case ActivityType.rejectAdvance:
      return {
        "title": "تم رفض السلفة",
        "description": isEmployee
            ? "تم رفض طلبك بقيمة ${metadata['requested_amount']} جنيه"
            : "تم رفض سلفة ${metadata['name']} بقيمة ${metadata['requested_amount']} جنيه",
        "icon": Icons.block,
        "color": Colors.red,
      };

    case ActivityType.updatePenalty:
      return {
        "title": "تم تعديل الجزاء",
        "description": isEmployee
            ? "تم تعديل الجزاء الخاص بك"
            : "تم تعديل جزاء للموظف ${metadata['name']}",
        "icon": Icons.edit,
        "color": Colors.orange,
      };

    case ActivityType.cancelPenalty:
      return {
        "title": "تم إلغاء الجزاء",
        "description": isEmployee
            ? "تم إلغاء الجزاء الخاص بك"
            : "تم إلغاء جزاء للموظف ${metadata['name']}",
        "icon": Icons.cancel,
        "color": Colors.red,
      };
    case ActivityType.requestLeave:
      return {
        "title": "طلب إجازة",
        "description": isEmployee
            ? "طلبت إجازة ${metadata['type']} لمدة ${metadata['days']} يوم"
            : "${metadata['employee_name']} طلب إجازة ${metadata['type']} لمدة ${metadata['days']} يوم",
        "icon": Icons.event_note,
        "color": Colors.orange,
      };

    default:
      return {
        "title": "نشاط جديد",
        "description": "",
        "icon": Icons.info,
        "color": Colors.grey,
      };
  }
}
