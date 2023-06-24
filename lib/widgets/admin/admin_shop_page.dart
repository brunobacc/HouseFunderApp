import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/utils/bottom_navigation_bar_widget.dart';
import '../../modules/product.dart';
import '../../data/products.dart';
import '../../modules/user.dart';
import '../popups/add_product_popup.dart';
import '../popups/pop_up_buy_product.dart';
import '../utils/drawer_widget.dart';

class ShopPageAdmin extends StatefulWidget {
  final String? token;
  final User? user;
  const ShopPageAdmin({required this.token, required this.user, super.key});

  static const String routeName = '/shopadmin';

  @override
  State<ShopPageAdmin> createState() => _ShopPageAdminState();
}

class _ShopPageAdminState extends State<ShopPageAdmin> {
  late final Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = Products.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shop',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: DrawerWidget(
        user: widget.user,
        token: widget.token,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error ?? "Error occurred"}');
                  } else if (snapshot.hasData) {
                    List<Product> products = snapshot.data!;
                    return GridView.builder(
                      itemCount: products.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return InkWell(
                            child: Card(
                              child: Icon(Icons.add),
                            ),
                            onTap: () async {
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Create(),
                              );
                            },
                          );
                        }
                        if (index == 0) {
                          return InkWell(
                            child: const Card(
                              child: Icon(
                                Icons.add,
                                size: 50,
                              ),
                            ),
                            onTap: () {
                              ProductPopUp.create(context);
                              Products.fetchProducts();
                            },
                          );
                        }
                        index -= 1;
                        Product product = products[index];
                        return InkWell(
                          onTap: () async {
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => PopUpBuyProduct(
                                product: product,
                              ),
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
                                    'assets/images/products/${snapshot.data![index].image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
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
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${product.price} Points',
                                          style: const TextStyle(
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
                    );
                  } else {
                    return const Center(
                      child: Text('Zero products to show!'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 0,
        token: widget.token,
      ),
    );
  }
}
