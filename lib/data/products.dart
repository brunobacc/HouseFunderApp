import 'dart:convert';

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
      products =
          List<Product>.from(iterable.map((c) => Product.fromJson(c)));

      // return deserialized list of objects
      return products;
    } else {
      throw Exception('Failed to load Products');
    }
  }
}