import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:projeto_computacao_movel/modules/project_financed.dart';

class ProjectsFinanced {
  static const String url = '10.0.2.2:5048';

  static Future<List<ProjectFinanced>> fetchNext(int userId) async {
    // variables
    Iterable iterable;
    List<ProjectFinanced> projectsFinanced;

    // ask data to server
    final response =
        await http.get(Uri.http(url, '/api/projectsfinancedquery/$userId'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      projectsFinanced = List<ProjectFinanced>.from(
          iterable.map((c) => ProjectFinanced.fromJson(c)));

      // return deserialized list of objects
      return projectsFinanced;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
