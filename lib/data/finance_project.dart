import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_computacao_movel/data/users.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/modules/user.dart';

class FinanceProject {
  static const String url = '10.0.2.2:5048';

  static Future<bool> financeProject(
      Project project, double amount, String? token) async {
    // variables
    Future<User?> user;
    if (token != null) {
      user = Users.fetchNext(token);
      user.then((value) async {
        try {
          final response = await http.put(
            Uri.http(url, '/api/player/${project.projectId}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Token': token,
            },
            body: jsonEncode(<String, dynamic>{
              "financer_id": value?.userId,
              "project_id": project.projectId,
              "financed_value": amount,
              "financed_date": DateTime.now(),
            }),
          );

          //print('Response Body: ${response.body}');
          //print('Status Code: ${response.statusCode}');

          // this "if" is needed to give the administrator information after trying to delete a player
          if (response.statusCode == 200) {
            return true;
          }
          return false;
        } catch (e) {
          //print('Error: $e');
          return false;
        }
      }).catchError(
        (error) => throw Exception('Problems getting the user!'),
      );
    }
    return false;
  }
}
