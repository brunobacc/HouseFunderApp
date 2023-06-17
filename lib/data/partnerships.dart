import 'package:projeto_computacao_movel/modules/partnership.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Partnerships {
  static const String url = '10.0.2.2:5048';

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
}
