import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';

import '../modules/product.dart';
import '../modules/products.dart';

class ShopPageWidget extends StatefulWidget {
  @override
  State<ShopPageWidget> createState() => _ShopPageWidgetState();
}

class _ShopPageWidgetState extends State<ShopPageWidget> {
  late Products products;

  @override
  void initState() {
    super.initState();
    products = Products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: products.countProducts > 0
                ? GridView.builder(
                    itemCount: products.countProducts,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products.list[index];
                      return Card(
                        child: Column(
                          children: [
                            Image.asset(product.image),
                            Text(product.title),
                            Text(product.description),
                            Text('\$${product.price.toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('Zero products to show!'),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 0),
    );
  }
}
