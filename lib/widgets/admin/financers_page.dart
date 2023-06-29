import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import '../../modules/financer.dart';
import '../../modules/user.dart';
import '../utils/drawer_widget.dart';

class FinancersAdminPage extends StatefulWidget {
  final String? token;
  final User? user;
  const FinancersAdminPage(
      {required this.token, required this.user, super.key});

  static const String routeName = '/financers';

  @override
  State<FinancersAdminPage> createState() => _FinancersAdminPageState();
}

class _FinancersAdminPageState extends State<FinancersAdminPage> {
  late Future<List<Financer>> financers;

  @override
  void initState() {
    super.initState();
    financers = Users.fetchFinancers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(token: widget.token, user: widget.user),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Financers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Financer>>(
              future: financers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error occurred: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Financer>? financers = snapshot.data;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: financers?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      final Financer financer = financers![index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://housefunderstorage1.blob.core.windows.net/images/${snapshot.data![index].image}',
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      financer.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${financer.financingDone}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        financer.totalAmountFinanced
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Text('Zero financers to show');
              },
            ),
          ),
        ],
      ),
    );
  }
}
