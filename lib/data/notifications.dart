import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modules/user_notification.dart';

class Notifications {
  static const String url = '10.0.2.2:5048';

  static Future<List<UserNotification>> fetchNext(
      String? token, int financerId) async {
    // variables
    Iterable iterable;
    List<UserNotification> notifications;

    // add the parameters
    final queryParameters = {'financer_id': '$financerId'};

    // ask data to server
    final response = await http.get(Uri.http(
      url,
      '/api/notifications/financer_id',
      queryParameters,
    ));

    // deserialize process for a list
    iterable = json.decode(response.body);

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

  static Future<bool> delete(String? token, int notification_id) async {
    // ask data to server
    final response = await http.delete(Uri.http(
      url,
      '/api/notifications/$notification_id',
    ));

    if (response.statusCode == 200) {
      bool status = bool.parse(response.body);
      if (status) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to load Products');
    }
  }
}
