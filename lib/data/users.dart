import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_computacao_movel/modules/user.dart';

class Users {
  static const String url = '10.0.2.2:5048';

  static Future<User?> fetchNext(String? token) async {
    // variables
    User user;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/users/$token'));

    if (response.statusCode == 200) {
      // deserialize the body
      user = User.fromJson(jsonDecode(response.body));

      // return the deserialized user
      return user;

      // token sent without correspondence
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw Exception('Failed to load User');
    }
  }
}
