import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_validation.dart';
import '../../modules/project.dart';
import '../../modules/user.dart';
import '../utils/bottom_navigation_bar_widget.dart';
import '../utils/drawer_widget.dart';

class ValidatePage extends StatefulWidget {
  final String? token;
  final User? user;
  const ValidatePage({required this.token, required this.user, super.key});

  static const String routeName = '/validateProposal';

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  late final Future<List<Project>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = Projects.fetchProjectsForValidation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proposals',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(token: widget.token, user: widget.user),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            // Projects
            Expanded(
              child: FutureBuilder<List<Project>>(
                future: _projects,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final filteredProjects = snapshot.data!
                        .where((project) => project.statusId == 4)
                        .toList();
                    final filteredPartnersProjects = snapshot.data!
                        .where((project) =>
                            project.statusId == 5 &&
                            project.partnershipId == widget.user!.userId)
                        .toList();
                    final itemCount = widget.user?.permissionLevel == 3
                        ? filteredProjects.length
                        : filteredPartnersProjects.length;
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: itemCount,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.user?.permissionLevel == 3) {
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
                                    'https://housefunderstorage1.blob.core.windows.net/projects/${filteredProjects[index].image}',
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
                                          filteredProjects[index].location,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '${filteredProjects[index].finalValue.toString()}€',
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
                                      filteredProjects[index].description,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () => PopUpValidation.validate(
                                context: context,
                                project: filteredProjects[index],
                                token: widget.token,
                                user: widget.user,
                              ),
                            ),
                          );
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
                                    'https://housefunderstorage1.blob.core.windows.net/projects/${filteredPartnersProjects[index].image}',
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
                                          filteredPartnersProjects[index]
                                              .location,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '${filteredPartnersProjects[index].finalValue.toString()}€',
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
                                      filteredPartnersProjects[index]
                                          .description,
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () => PopUpValidation.validate(
                                context: context,
                                project: filteredPartnersProjects[index],
                                token: widget.token,
                                user: widget.user,
                              ),
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
      bottomNavigationBar: widget.user!.permissionLevel == 2
          ? BottomNavigationBarWidget(
              selectedIndex: 0,
              token: widget.token,
              user: widget.user,
            )
          : null,
    );
  }
}
