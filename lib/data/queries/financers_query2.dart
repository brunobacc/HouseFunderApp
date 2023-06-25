import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../modules/queries/financers_query2.dart';

class FinancersQuery2 {
  static const String url = '10.0.2.2:5048';

  static Future<List<FinancerQuery2>> fetchFinancers() async {
    // variables
    Iterable iterable;
    List<FinancerQuery2> financers;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/FinancersQuery2'));

    // deserialize process for a list
    iterable = json.decode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      financers = List<FinancerQuery2>.from(
          iterable.map((f) => FinancerQuery2.fromJson(f)));

      // return deserialized list of objects
      return financers;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
