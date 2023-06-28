import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../modules/product.dart';

class Products {
  static const String url = '10.0.2.2:5048';

  static Future<List<Product>> fetchProducts() async {
    // variables
    Iterable iterable;
    List<Product> products;

    // ask data to server
    final response = await http.get(Uri.http(url, '/api/products'));

    // deserialize process for a list
    iterable = json.decode(response.body);

    if (response.statusCode == 200) {
      // deserialize the body
      products = List<Product>.from(iterable.map((c) => Product.fromJson(c)));

      // return deserialized list of objects
      return products;
    } else {
      throw Exception('Failed to load Products');
    }
  }

  static Future<bool> createProduct(
    String title,
    String description,
    File imageFile,
    int price,
    int? value,
  ) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('POST', Uri.http(url, '/api/products'));
    request.headers.addAll(headers);
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['value'] = value.toString();

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

  static Future<bool> editProduct(
    String title,
    String description,
    File imageFile,
    int price,
    int? value,
    int productId,
  ) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
        'POST', Uri.http(url, '/api/products/$productId'));
    request.headers.addAll(headers);
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imageFile.path));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['value'] = value.toString();

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

  static Future<bool> delete(String? token, int productId) async {
    final response = await http.delete(Uri.http(
      url,
      '/api/Products/$productId',
    ));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
