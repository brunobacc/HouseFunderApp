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
      products = List<Product>.from(iterable.map((c) => Product.fromJson(c)));

      // return deserialized list of objects
      return products;
    } else {
      throw Exception('Failed to load Products');
    }
  }

  static Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.http(url, '/api/products'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
      'description': product.description,
      'image': product.image,
      'price': product.price,
      'title': product.title
      }),
    );

    if (response.statusCode == 200) {
      print('Product added successfully');
    } else {
      throw Exception('Failed to add product');
    }
  }
}
