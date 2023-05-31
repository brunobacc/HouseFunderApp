import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/popups/buy_product.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';

import '../modules/product.dart';
import '../modules/products.dart';
import 'drawer_widget.dart';

class ShopPageWidget extends StatefulWidget {
  @override
  State<ShopPageWidget> createState() => _ShopPageWidgetState();
}

class _ShopPageWidgetState extends State<ShopPageWidget> {
  late Products products;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    products = Products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.all(
                0), // used to make the icon with centered inside the button
            icon: const Icon(
              Icons.menu,
              size: 36,
              color: Colors.black,
            ),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
      ),
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
                      return InkWell(
                        onTap: () async {
                          double? val = await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => BuyProductPopUp(
                                price: product.price,
                                title: product.title,
                                image: product.image),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${product.price} Points',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
