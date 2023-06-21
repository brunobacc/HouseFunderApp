import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/queries/financers_query2.dart';
import '../../data/queries/financers_query2.dart';

class FinancersAdminPage extends StatefulWidget {
  const FinancersAdminPage({Key? key}) : super(key: key);

  static const String routeName = '/financers';

  @override
  State<FinancersAdminPage> createState() => _FinancersAdminPageState();
}

class _FinancersAdminPageState extends State<FinancersAdminPage> {
  late Future<List<FinancerQuery2>> financers;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    financers = FinancersQuery2.fetchFinancers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.menu,
              size: 36,
            ),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),
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
            child: FutureBuilder<List<FinancerQuery2>>(
              future: financers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error occurred: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<FinancerQuery2>? financers = snapshot.data;
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
                      final FinancerQuery2 financer = financers![index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/financers/${financer.image}',
                                  fit: BoxFit.fill,
                                ),
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
                                  const SizedBox(height: 80),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' ${financer.financingDone}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        ' ${financer.totalAmountFinanced}',
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
