import 'package:projeto_computacao_movel/modules/product.dart';

class Products {
  List<Product> _products = [];

  Products() {
    _products = [
      Product(
          productId: 1,
          image: 'assets/images/5euros.png',
          title: 'Finance 5 euros',
          description: 'Finance 5 euros to an active project of your choice.',
          price: 30),
      Product(
          productId: 2,
          image: 'assets/images/10euros.png',
          title: 'Finance 10 euros',
          description: 'Finance 10 euros to an active project of your choice.',
          price: 50),
      Product(
          productId: 3,
          image: 'assets/images/15euros.png',
          title: 'Finance 15 euros',
          description: 'Finance 15 euros to an active project of your choice.',
          price: 70),
      Product(
          productId: 4,
          image: 'assets/images/20euros.png',
          title: 'Finance 20 euros',
          description: 'Finance 20 euros to an active project of your choice.',
          price: 90),
      Product(
          productId: 5,
          image: 'assets/images/50euros.png',
          title: 'Finance 50 euros',
          description: 'Finance 50 euros to an active project of your choice.',
          price: 220),
      Product(
          productId: 6,
          image: 'assets/images/100euros.png',
          title: 'Finance 100 euros',
          description: 'Finance 100 euros to an active project of your choice.',
          price: 420),
    ];
  }
  List<Product> get list => _products;
  int get countProducts => _products.length;
}
