String generateSafeFileName(String originalName) {
  // 🔹 نفصل الامتداد
  final parts = originalName.split('.');
  final extension = parts.length > 1 ? parts.last : '';

  // 🔹 ناخد الاسم بدون الامتداد
  final nameWithoutExt = parts.length > 1
      ? parts.sublist(0, parts.length - 1).join('.')
      : originalName;

  // 🔹 نشيل أي حاجة مش انجليزي/أرقام
  final sanitized = nameWithoutExt
      .replaceAll(RegExp(r'[^\w\s-]'), '') // يشيل العربي والرموز
      .replaceAll(RegExp(r'\s+'), '_'); // المسافات تبقى _

  // 🔹 نضيف timestamp علشان ميحصلش تكرار
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  // 🔹 نرجع الاسم النهائي
  return extension.isNotEmpty
      ? '${timestamp}_$sanitized.$extension'
      : '${timestamp}_$sanitized';
}
