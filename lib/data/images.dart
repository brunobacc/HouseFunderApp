import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Images {
  static const String url = '10.0.2.2:5048';
  static Future<bool> uploadImage(File imageFile) async {
    var headers = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.http(url, '/api/file'));
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Image uploaded successfully
        return true;
      } else {
        // Handle error response
        return false;
      }
    } catch (e) {
      // Handle network or server errors
      throw Exception('Error: $e');
    }
  }
}
