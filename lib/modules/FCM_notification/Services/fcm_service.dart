import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMService {
  final String projectId = "hrxsystem-1da8a";

  Future<String?> getAccessToken() async {
    // تحميل ملف الخدمة
    final jsonString = await rootBundle.loadString(
      'resources/assets/ServiceAccount/hrxsystem-1da8a-a07df6c80e80.json',
    );
    final jsonMap = json.decode(jsonString);

    // استخراج البيانات
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonMap);
    // نطاق FCM
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // توليد Access Token
    final authClient = await clientViaServiceAccount(
      accountCredentials,
      scopes,
    );

    return authClient.credentials.accessToken.data;
  }

  Future<bool> sendNotification({
    required String title,
    required String body,
    String? topic,
    String? token,
    String pageNo = "None",
    String notiType = "Orders",
  }) async {
    if (topic == null && token == null) {
      throw Exception("يجب اختيار topic أو token");
    }

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      return false;
    }

    final url =
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";

    final message = {
      "message": {
        if (topic != null) "topic": topic,
        if (token != null) "token": token,
        "notification": {"title": title, "body": body},
        "data": {"PageNo": pageNo, "NotiType": notiType},
      },
    };

    final headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(message),
    );
    return response.statusCode == 200;
  }
}
