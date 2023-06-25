import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/validate_projects.dart';

import '../../modules/arguments/project_arguments.dart';
import '../../modules/project.dart';
import '../../modules/user.dart';
import '../utils/drawer_widget.dart';

class AdminValidatePage extends StatefulWidget {
  final String? token;
  final User? user;
  const AdminValidatePage({required this.token, required this.user, super.key});

  static const String routeName = '/validateProposal';

  @override
  State<AdminValidatePage> createState() => _AdminValidatePageState();
}

class _AdminValidatePageState extends State<AdminValidatePage> {
  late final Future<List<Project>> projects;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projects = ValidateProjects.fetchNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(token: widget.token, user: widget.user),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            // Projects
            Expanded(
              child: FutureBuilder<List<Project>>(
                future: projects,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.user?.permissionLevel == 3) {
                          if (snapshot.data![index].statusId == 4) {
                            return Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://housefunderstorage.blob.core.windows.net/projects/${snapshot.data![index].image}',
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            snapshot.data![index].location,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            '${snapshot.data![index].finalValue.toString()}€',
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Text(
                                        snapshot.data![index].description,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, '/projectDetailsValidate',
                                    arguments: ProjectArguments(widget.token,
                                        snapshot.data![index], widget.user)),
                              ),
                            );
                          }
                        } else {
                          return Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://housefunderstorage.blob.core.windows.net/projects/${snapshot.data![index].image}',
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          snapshot.data![index].location,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '${snapshot.data![index].finalValue.toString()}€',
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      snapshot.data![index].description,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, '/projectDetails',
                                  arguments: ProjectArguments(widget.token,
                                      snapshot.data![index], widget.user)),
                            ),
                          );
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
