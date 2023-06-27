import 'dart:convert';
import '../modules/user_notification.dart';
import 'package:http/http.dart' as http;

class Notifications {
  static const String url = '10.0.2.2:5048';

  static Future<List<UserNotification>> fetchNext(
      String? token, int financerId) async {
    // variables
    Iterable iterable;
    List<UserNotification> notifications;

    // ask data to server
    final response = await http.get(Uri.http(
      url,
      '/api/notifications/$financerId',
    ));

    // deserialize process for a list
    iterable = json.decode(response.body);

    //print(response.statusCode);

    if (response.statusCode == 200) {
      // deserialize the body
      notifications = List<UserNotification>.from(
          iterable.map((c) => UserNotification.fromJson(c)));
      // return deserialized list of objects
      return notifications;
    } else {
      throw Exception('Failed to load Products');
    }
  }

  static Future<bool> delete(String? token, int notificationId) async {
    // ask data to server
    final response = await http.delete(Uri.http(
      url,
      '/api/notifications/$notificationId',
    ));

    if (response.statusCode == 200) {
      if (response.body == 'true') {
        return true;
      }
    } else {
      throw Exception('Failed to load Products');
    }
    return false;
  }
}
