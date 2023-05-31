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
                      return Stack(
                        children: [
                          Card(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Image.asset(product.image),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(product.title),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            right: 25,
                            child: Text('${product.price}Points',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
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
