import 'dart:convert';
import 'package:projeto_computacao_movel/modules/user.dart';
import '../modules/admnistrator.dart';
import '../modules/financer.dart';
import '../modules/partnership.dart';
import 'package:http/http.dart' as http;

class Users {
  static const String url = '10.0.2.2:5048';

  static Future<User?> fetchUser(String? token) async {
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

  static Future<List<Partnership>> fetchPartnerships() async {
    // variables
    Iterable iterable;
    List<Partnership> partnerships;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/partnerships'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      partnerships =
          List<Partnership>.from(iterable.map((c) => Partnership.fromJson(c)));

      // return deserialized list of objects
      return partnerships;
    } else {
      throw Exception('Failed to load Partnerships');
    }
  }

  static Future<List<Administrator>> fetchAdministrators() async {
    // variables
    Iterable iterable;
    List<Administrator> administrators;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/Administrators'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      administrators = List<Administrator>.from(
          iterable.map((c) => Administrator.fromJson(c)));

      // return deserialized list of objects
      return administrators;
    } else {
      throw Exception('Failed to load Partnerships');
    }
  }

  static Future<List<Financer>> fetchFinancers() async {
    // variables
    Iterable iterable;
    List<Financer> financers;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/FinancersQuery2'));

    // deserialize process for a list
    iterable = json.decode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      financers =
          List<Financer>.from(iterable.map((f) => Financer.fromJson(f)));

      // return deserialized list of objects
      return financers;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<bool> validEmail(String email) async {
    try {
      final response = await http.put(
        Uri.http(url, '/api/users/validEmail/$email'),
      );

      //print('Response Body: ${response.body}');
      //print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.body == 'true') {
          return true;
        }
      }
    } catch (e) {
      //print('Error: $e');
      throw Exception('Error: $e');
    }
    return false;
  }

  static Future<void> resetPassword(String email, String password) async {
    try {
      final response = await http.put(
        Uri.http(url, '/api/users/resetPassword/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          password,
        ),
      );

      //print('Response Body: ${response.body}');
      //print('Status Code: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw Exception('Something happen when updating the password!');
      }
    } catch (e) {
      //print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  static Future<bool> register(
    String username,
    String email,
    String password,
    int level,
  ) async {
    try {
      print('$username | $email | $password | $level');
      // add the parameters
      final queryParameters = {
        'username': username,
        'email': email,
        'password': password,
        'permission_level': level.toString(),
      };
      print('ola');

      final response = await http.post(
        Uri.http(url, '/api/register', queryParameters),
      );

      print('Response Body: ${response.body}');
      print('Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        if (response.body == 'true') {
          return true;
        }
      }
    } catch (e) {
      ('Error: $e');
    }
    return false;
  }

  static Future<String?> login(
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

  static Future<bool> editProfile(String username, String email,
      String? password, String? token, int userId) async {
    if (password == '') {
      password = null;
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

  static Future<void> updatePoints(
      int points, String? token, int userId) async {
    try {
      final response = await http.put(
        Uri.http(url, '/api/users/points/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': token!,
        },
        body: jsonEncode(
          points,
        ),
      );

      //print('Response Body: ${response.body}');
      //print('Status Code: ${response.statusCode}');

      if (response.statusCode != 200) {
        throw Exception('Something happen when updating the points!');
      }
    } catch (e) {
      //print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
