import 'package:http/http.dart' as http;

class Login {
  static const String url = '127.0.0.1:5048';

  static Future<String?> validate(
    String email,
    String password,
  ) async {
    // variables
    String? token;

    // add the parameters
    final queryParameters = {
      'email': email,
      'password': password,
    };

    // ask data to server
    final response =
        await http.post(Uri.http(url, '/api/login', queryParameters));

    if (response.statusCode == 200) {
      // deserialize the body
      token = response.body;

      // API returns an empty string but we need it null
      if (token == '') {
        token = null;
      }

      // return the deserialized token
      return token;
    } else {
      throw Exception('Failed to load Login');
    }
  }
}
