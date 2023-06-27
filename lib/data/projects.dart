import 'dart:convert';
import 'dart:io';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/modules/project_financer.dart';
import '../modules/project_financed.dart';
import '../modules/user.dart';
import 'package:http/http.dart' as http;

class Projects {
  static const String url = '10.0.2.2:5048';

  static Future<List<Project>> fetchProjects() async {
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

  static Future<List<ProjectFinanced>> fetchFinancedP(int userId) async {
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

  static Future<List<Project>> fetchFinishedP(int userId) async {
    // variables
    Iterable iterable;
    List<Project> projectsFinished;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/projects/$userId'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      // deserialize the body
      projectsFinished =
          List<Project>.from(iterable.map((c) => Project.fromJson(c)));

      // return deserialized list of objects
      return projectsFinished;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<List<Project>> fetchFilteredP(
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

    if (response.body.isNotEmpty) {
      // deserialize process for a list
      iterable = json.decode(response.body);
    } else {
      throw Exception('No permission!');
    }

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

  static Future<List<ProjectFinancer>> fetchProjectFinancers(
      int projectId) async {
    // variables
    Iterable iterable;
    List<ProjectFinancer> financers;

    // add the parameters
    final queryParameters = {'project_id': '$projectId'};

    // ask data to server
    final response = await http.get(Uri.http(
      url,
      '/api/financersquery/project_id',
      queryParameters,
    ));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      financers = List<ProjectFinancer>.from(
          iterable.map((f) => ProjectFinancer.fromJson(f)));

      // return deserialized list of objects
      return financers;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<List<Project>> fetchProjectsForValidation() async {
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

  static Future<bool> financeProject(
      Project project, double amount, String? token, User? user) async {
    // variables
    if (token != null) {
      try {
        final response = await http.post(
          Uri.http(url, '/api/FinanceProject'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Token': token,
          },
          body: jsonEncode(<String, dynamic>{
            "financer_id": user?.userId,
            "project_id": project.projectId,
            "financed_value": amount,
            "financed_date": DateTime.now()
                .toIso8601String(), // need the toIso8601String() to accept in JSON
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

  static Future<bool> validateProject(
      String? token, int statusId, int projectId) async {
    if (token != null) {
      try {
        final response = await http.put(
          Uri.http(url, '/api/Projects/status/$projectId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Token': token,
          },
          body: jsonEncode(statusId),
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

  static Future<bool> proposeProject(int partnershipId, String location,
      File imageFile, String title, String description, double value) async {
    var headers = {
      //'Content-Type': 'application/json',
      'Content-Type': 'multipart/form-data',
      //'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.http(url, '/api/projects'));
    request.headers.addAll(headers);
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    request.fields['status_id'] = '4';
    request.fields['category_id'] = '1';
    request.fields['partnership_id'] = partnershipId.toString();
    request.fields['location'] = location;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['final_value'] = value.toString();

    try {
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle network or server errors
      throw Exception('Error: $e');
    }
  }

  static Future<void> addProject(Project project, String? token) async {
    final response = await http.post(
      Uri.http(url, '/api/projects'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Token': token!
      },
      body: jsonEncode(<String, dynamic>{
        "status_id": project.statusId,
        "category_id": project.categoryId,
        "partnership_id": project.partnershipId,
        "location": project.location,
        "image": project.image,
        "title": project.title,
        "description": project.description,
        "total_financed": project.totalFinanced,
        "final_value": project.finalValue,
        "date_created": project.dateCreated,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add product');
    }
  }
}
