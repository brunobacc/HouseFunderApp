import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../modules/queries/financer_query.dart';

class FinancersQuery {
  static const String url = '10.0.2.2:5048';

  static Future<List<FinancerQuery>> fetchNext(int projectId) async {
    // variables
    Iterable iterable;
    List<FinancerQuery> financers;

    // add the parameters
    final queryParameters = {'projectId': '$projectId'};

    // ask data to server
    final response = await http.get(Uri.http(
      url,
      '/api/financersquery/projectId',
      queryParameters,
    ));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      financers = List<FinancerQuery>.from(
          iterable.map((f) => FinancerQuery.fromJson(f)));

      // return deserialized list of objects
      return financers;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
