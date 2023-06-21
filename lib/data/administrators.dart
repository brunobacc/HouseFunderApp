import 'package:projeto_computacao_movel/modules/partnership.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modules/admnistrator.dart';

class Administrators {
  static const String url = '10.0.2.2:5048';

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
}
