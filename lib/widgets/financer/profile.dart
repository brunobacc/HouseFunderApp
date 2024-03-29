import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/modules/project_financed.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_ups_financer.dart';
import 'package:projeto_computacao_movel/widgets/utils/bottom_navigation_bar_widget.dart';
import '../../data/users.dart';
import '../../modules/user.dart';
import '../utils/drawer_widget.dart';

class Profile extends StatefulWidget {
  final String? token;
  final int? level;
  const Profile({required this.token, required this.level, super.key});

  static const String routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<ProjectFinanced>? _projectsFinanced;
  List<Project>? _projectsFinished;
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
    _user = Users.fetchUser(widget.token);
    widget.level == 2 ? _fetchFinishedProjects() : _fetchFinancedProjects();
  }

  Future<void> _fetchFinishedProjects() async {
    _user.then((user) async {
      if (user != null) {
        final projects = await Projects.fetchFinishedP(user.userId);
        setState(() {
          _projectsFinished = projects;
        });
      }
    });
  }

  Future<void> _fetchFinancedProjects() async {
    _user.then((user) async {
      if (user != null) {
        final projects = await Projects.fetchFinancedP(user.userId);
        setState(() {
          _projectsFinanced = projects;
        });
      }
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
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  ),
                ),
              ],
            );
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            children: [
              FutureBuilder(
                future: _user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          // give space between the top bar(menu icon and title) and user information
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              // User Image
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      'https://housefunderstorage1.blob.core.windows.net/images/${snapshot.data!.image}',
                                      height: 130,
                                      width: 130,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () => PopUpsFinancer.ediImage(
                                          context: context,
                                          user: snapshot.data,
                                          token: widget.token),
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Info about the user (Username and Email) and button to edit profile
                              SizedBox(
                                // used the size box, because the column is not taking up all the space on the main axis within the row
                                height: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        snapshot.data!.username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        snapshot.data!.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: ElevatedButton(
                                          child: Text(
                                            'Edit Profile',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          onPressed: () => PopUpsFinancer.edit(
                                              context: context,
                                              user: snapshot.data,
                                              token: widget.token)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Table(
                            // present data in a table about what the user has done in the application
                            border: TableBorder.all(
                              width: 1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            children: [
                              snapshot.data!.permissionLevel == 1
                                  ? TableRow(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE5DFDF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Financing',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Done',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                '${snapshot.data!.financingDone}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Total Amount',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Financed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.totalAmountFinanced
                                                    .toStringAsFixed(2),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Accepted',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Projects',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                '${snapshot.data!.acceptedProjects}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : TableRow(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE5DFDF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Active',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Projects',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                snapshot.data!.activeProjects
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Finished',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Projects',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                snapshot.data!.finishedProjects
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Validated',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                'Projects',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.validatedProposals
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              widget.level == 2
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Finished Projects',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Financed Projects',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
              // Projects
              widget.level == 2
                  ? Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: _projectsFinished?.length ??
                            0, // need null-coalescing operators to don't present the error "Null check operator used on a null value"
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            title: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://housefunderstorage1.blob.core.windows.net/projects/${_projectsFinished![i].image}',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    color: Colors.black54,
                                    width: 200,
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      _projectsFinished![i].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: _projectsFinanced?.length ??
                            0, // need null-coalescing operators to don't present the error "Null check operator used on a null value"
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                              title: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://housefunderstorage1.blob.core.windows.net/projects/${_projectsFinanced![i].image}',
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      color: Colors.black54,
                                      width: 200,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        _projectsFinanced![i].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      color: Colors.black54,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        _projectsFinanced![i]
                                            .totalFinancedUser
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () => PopUpsFinancer.financedProjects(
                                  context: context,
                                  token: widget.token,
                                  project: _projectsFinanced![i]));
                        },
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BottomNavigationBarWidget(
                selectedIndex: 2,
                token: widget.token,
                user: snapshot.data,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
