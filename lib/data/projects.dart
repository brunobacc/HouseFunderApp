import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_computacao_movel/modules/project.dart';

class Projects {
  static const String url = '10.0.2.2:5048';

  static Future<List<Project>> fetchNext() async {
    // variables
    Iterable iterable;
    List<Project> projects;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/projects'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      projects = List<Project>.from(iterable.map((c) => Project.fromJson(c)));

      // return deserialized list of objects
      return projects;
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
