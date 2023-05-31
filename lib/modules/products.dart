import 'package:projeto_computacao_movel/modules/product.dart';

class Products {
  List<Product> _products = [];

  Products() {
    _products = [
      Product(
          productId: 1,
          image: 'assets/images/5euros.png',
          title: 'Finance 5 dollars',
          description: 'Finance 5 dollars',
          price: 30),
      Product(
          productId: 2,
          image: 'assets/images/10euros.png',
          title: 'Finance 10 dollars',
          description: 'Finance 10 dollars',
          price: 50),
      Product(
          productId: 3,
          image: 'assets/images/15euros.png',
          title: 'Finance 15 dollars',
          description: 'Finance 15 dollars',
          price: 70),
      Product(
          productId: 4,
          image: 'assets/images/20euros.png',
          title: 'Finance 20 dollars',
          description: 'Finance 20 dollars',
          price: 90),
      Product(
          productId: 5,
          image: 'assets/images/50euros.png',
          title: 'Finance 25 dollars',
          description: 'Finance 50 dollars',
          price: 220),
      Product(
          productId: 6,
          image: 'assets/images/100euros.png',
          title: 'Finance 30 dollars',
          description: 'Finance 100 dollars',
          price: 420),
    ];
  }
  List<Product> get list => _products;
  int get countProducts => _products.length;
}
