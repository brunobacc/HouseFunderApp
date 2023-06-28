import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import '../../modules/admnistrator.dart';
import '../../modules/user.dart';
import '../popups/pop_up_info.dart';
import '../popups/pop_ups_admin.dart';
import '../utils/drawer_widget.dart';

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
  late Future<List<Administrator>> administrators;

  @override
  void initState() {
    super.initState();
    administrators = Users.fetchAdministrators();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(token: widget.token, user: widget.user),
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
                            PopUpsAdmin.createAdmin(context, widget.token);
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
                            Stack(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://housefunderstorage.blob.core.windows.net/images/${administrator.image}',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: 20,
                                  child: IconButton(
                                    onPressed: () => PopUpsAdmin.editAdmin(
                                        context: context,
                                        user: administrator,
                                        token: widget.token),
                                    icon: const Icon(Icons.edit,
                                        color: Colors.white, size: 25),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: IconButton(
                                    onPressed: () => showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Are you sure?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          content: Text(
                                            "That you want to delete this administrator.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Future<bool> userStatus =
                                                        Users.delete(
                                                            widget.token,
                                                            administrator
                                                                .userId);
                                                    // when projectStatus receives a bool value, it will present an information popUp
                                                    userStatus.then(
                                                      (value) {
                                                        value
                                                            ? PopUpInfo.info(
                                                                context,
                                                                'Success',
                                                                'The Administrator was deleted!',
                                                                widget.token,
                                                              )
                                                            : PopUpInfo.info(
                                                                context,
                                                                'Error',
                                                                'Something happen when it was deleting the administrator!',
                                                                widget.token,
                                                              );
                                                      },
                                                    );
                                                  },
                                                  child: const Text("Continue"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white, size: 25),
                                  ),
                                ),
                              ],
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
                                      administrator.validatedProposals
                                          .toString(),
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
