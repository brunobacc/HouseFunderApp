import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterUser {
  static const String url = '10.0.2.2:5048';

  static Future<bool> register(
    String username,
    String email,
    String password,
    int level,
  ) async {
    try {
      final response = await http.post(
        Uri.http(url, '/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "username": username,
          "email": email,
          "password": password,
          "permission_level": level
        }),
      );

      //print('Response Body: ${response.body}');
      //print('Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      ('Error: $e');
      return false;
    }
  }
}
