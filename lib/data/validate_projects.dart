import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_computacao_movel/modules/project.dart';

class ValidateProjects {
  static const String url = '10.0.2.2:5048';

  static Future<List<Project>> fetchNext() async {
    // variables
    Iterable iterable;
    List<Project> projects;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/ProjectsAdmin'));

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

    static Future<bool> validateProject( String? token, int projectId, statusId) async {

    if (token != null) {
      try {
        final response = await http.put(
          Uri.http(url, '/api/projects/status/$projectId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Token': token,
          },
          body: jsonEncode(<String, dynamic>{
            "status_id": statusId,
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
