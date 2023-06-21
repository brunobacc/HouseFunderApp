import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfileRequest {
  static const String url = '10.0.2.2:5048';

  static Future<bool> editProfile(String username, String email,
      String? password, String? image, String? token, int userId) async {
    if (password == '') {
      password = null;
    }
    if (image == '') {
      image = null;
    }

    if (token != null) {
      try {
        final response = await http.put(
          Uri.http(url, '/api/users/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Token': token,
          },
          body: jsonEncode(<String, dynamic>{
            "username": username,
            "email": email,
            "password": password,
            "image": image,
          }),
        );

        //print('Response Body: ${response.body}');
        //print('Status Code: ${response.statusCode}');

        if (response.statusCode == 200) {
          return true;
        }
        return false;
      } catch (e) {
        //print('Error: $e');
        return false;
      }
    }
    return false;
  }
}