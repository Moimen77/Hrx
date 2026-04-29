// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hrx/core/constant/Messages.dart';

validstring(String val, int min, int max, String type) {
  if (val.length > max) {
    return '$maxfileldlength $max';
  }
  if (val.isEmpty) {
    return emptyFieldField;
  }
  if (type == 'Username') {
    if (!GetUtils.isUsername(val)) {
      return isnotUsername;
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return isnotEmail;
    }
  }
  if (val.length < min) {
    return '$minfileldlength $min';
  }
}
