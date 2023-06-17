import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/drawer_widget.dart';

import '../data/partnerships.dart';
import '../modules/partnership.dart';

class PartnershipsPage extends StatefulWidget {
  const PartnershipsPage({Key? key}) : super(key: key);

  @override
  _PartnershipsPageState createState() => _PartnershipsPageState();
}

class _PartnershipsPageState extends State<PartnershipsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<Partnership>> partnerships;

  @override
  void initState() {
    super.initState();
    partnerships = Partnerships.fetchPartnerships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
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
          'Shop',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: partnerships,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error ?? "Error occurred"}');
                } else if (snapshot.hasData) {
                  List<Partnership>? partnerships = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: partnerships.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      final Partnership partnership = partnerships[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/partnerships/${snapshot.data![index].image}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    partnership.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Validated Proposals: ${partnership.validatedProposals}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
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
                return Text('Zero partnerships to show');
              },
            ),
          ),
        ],
      ),
    );
  }
}
