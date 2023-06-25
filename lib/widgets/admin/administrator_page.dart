import 'package:flutter/material.dart';
import '../../data/administrators.dart';
import '../../modules/admnistrator.dart';
import '../../modules/user.dart';
import '../popups/pop_ups_admin.dart';

class AdministratorsPage extends StatefulWidget {
  final String? token;
  final User? user;
  const AdministratorsPage(
      {required this.token, required this.user, super.key});

  static const String routeName = '/administrators';

  @override
  State<AdministratorsPage> createState() => _AdministratorsPageState();
}

class _AdministratorsPageState extends State<AdministratorsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<Administrator>> administrators;

  @override
  void initState() {
    super.initState();
    administrators = Administradores.fetchAdministrators();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //drawer: const DrawerWidget(),
      appBar: AppBar(
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
              future: administrators,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error ?? "Error occurred"}');
                } else if (snapshot.hasData) {
                  List<Administrator>? administrators = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: administrators.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return InkWell(
                          child: const Card(
                            child: Icon(
                              Icons.add,
                              size: 50,
                            ),
                          ),
                          onTap: () {
                            PopUpsAdmin.createAdmin(context);
                            Administradores.fetchAdministrators();
                          },
                        );
                      }
                      index -= 1;
                      final Administrator administrator = administrators[index];
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
                                  'assets/images/avatars/${snapshot.data![index].image}',
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
                                      administrator.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Validated Proposals: ${administrator.validatedProposals}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                return const Text('Zero administrators to show');
              },
            ),
          ),
        ],
      ),
    );
  }
}
