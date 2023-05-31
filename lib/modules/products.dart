import 'package:projeto_computacao_movel/modules/product.dart';

class Products {
  List<Product> _products = [];

  Products() {
    _products = [
      Product(productId: 1, image: 'assets/images/5euros.png', title: 'Finance 5 dollars', description: 'Finance 5 dollars', price: 5),
      Product(productId: 2, image: 'Produc2.jpg', title: 'Finance 10 dollars', description: 'Finance 10 dollars', price: 10),
      Product(productId: 3, image: 'Product3.jpg', title: 'Finance 15 dollars', description: 'Finance 15 dollars', price: 15),
      Product(productId: 4, image: 'Product4.jpg', title: 'Finance 20 dollars', description: 'Finance 20 dollars', price: 20),
      Product(productId: 5, image: 'Product5.jpg', title: 'Finance 25 dollars', description: 'Finance 25 dollars', price: 25),
      Product(productId: 6, image: 'Product6.jpg', title: 'Finance 30 dollars', description: 'Finance 30 dollars', price: 30),
      Product(productId: 7, image: 'Product7.jpg', title: 'Finance 35 dollars', description: 'Finance 35 dollars', price: 35),
      Product(productId: 8, image: 'Product8.jpg', title: 'Finance 40 dollars', description: 'Finance 40 dollars', price: 40),
      Product(productId: 9, image: 'Product9.jpg', title: 'Finance 45 dollars', description: 'Finance 45 dollars', price: 45),
      Product(productId: 10, image: 'Product10.jpg', title: 'Finance 50 dollars', description: 'Finance 50 dollars', price: 50),
    ];
  }
  List<Product> get list => _products;
  int get countProducts => _products.length;
}
