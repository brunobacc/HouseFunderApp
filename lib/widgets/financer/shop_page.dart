import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_ups_financer.dart';
import 'package:projeto_computacao_movel/widgets/utils/bottom_navigation_bar_widget.dart';
import '../../data/users.dart';
import '../../modules/product.dart';
import '../../data/products.dart';
import '../../modules/user.dart';
import '../utils/drawer_widget.dart';

class ShopPage extends StatefulWidget {
  final String? token;
  const ShopPage({required this.token, Key? key}) : super(key: key);

  static const String routeName = '/shop';

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late Future<List<Product>> products;
  User? _user;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    products = Products.fetchProducts();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await Users.fetchUser(widget.token);
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FutureBuilder<User?>(
          future: Users.fetchUser(widget.token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return DrawerWidget(token: widget.token, user: snapshot.data);
            }
            return AlertDialog(
              title: Text(
                "Wait",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "Please, wait until we receive your data.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shop',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Points: ${_user?.points ?? '??'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> products = snapshot.data!;
                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          Product product = products[index];
                          return InkWell(
                            onTap: () {
                              PopUpsFinancer.productBuy(
                                context,
                                product,
                                widget.token,
                                _user,
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
                                    child: Image.network(
                                      'https://housefunderstorage.blob.core.windows.net/products/${snapshot.data![index].image}',
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
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error ?? "Error occurred"}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Center(
                      child: Text('Zero products to show!'),
                    );
                  }),
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
