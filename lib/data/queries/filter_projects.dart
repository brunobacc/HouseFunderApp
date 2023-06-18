import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_computacao_movel/modules/project.dart';

class FilterProjects {
  static const String url = '10.0.2.2:5048';

  static Future<List<Project>> fetchNext(
      bool newest,
      bool oldest,
      bool lowHigh,
      bool highLow,
      double? minPrice,
      double? maxPrice,
      String? region,
      String? partnership) async {
    // variables
    Iterable iterable;
    List<Project> filterProjects;

    // add the parameters
    final queryParameters = {
      'newest': newest.toString(),
      'oldest': oldest.toString(),
      'low_high': lowHigh.toString(),
      'high_low': highLow.toString(),
      'min_value': minPrice?.toString() ?? '',
      'max_value': maxPrice?.toString() ?? '',
      'region': region ?? '',
      'partnership': partnership ?? '',
    };

    // ask data to server
    final response =
        await http.get(Uri.http(url, '/api/filterprojects', queryParameters));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      filterProjects =
          List<Project>.from(iterable.map((c) => Project.fromJson(c)));

      // return deserialized list of objects
      return filterProjects;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
