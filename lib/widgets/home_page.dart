import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import 'package:projeto_computacao_movel/modules/arguments/project_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/user_arguments.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_filter.dart';
import 'package:projeto_computacao_movel/widgets/utils/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/utils/drawer_widget.dart';
import '../modules/searchs/search_projects.dart';
import '../modules/user.dart';

class HomePage extends StatefulWidget {
  final bool newest;
  final bool oldest;
  final bool lowHigh;
  final bool highLow;
  final bool likes;
  final RangeValues? neededPrice;
  final String? region;
  final String? partnership;
  final double maxPrice;
  final String? token;
  const HomePage(
      {required this.newest,
      required this.oldest,
      required this.lowHigh,
      required this.highLow,
      required this.likes,
      required this.neededPrice,
      required this.region,
      required this.partnership,
      required this.maxPrice,
      required this.token,
      super.key});

  static const String routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Project>> _projects;
  late List<Project> projects;
  late double _maxPrice;
  User? _user;

  @override
  void initState() {
    super.initState();
    _maxPrice = widget.maxPrice;
    _projects = Projects.fetchFilteredP(
      widget.newest,
      widget.oldest,
      widget.lowHigh,
      widget.highLow,
      widget.neededPrice?.start,
      widget.neededPrice?.end,
      widget.region,
      widget.partnership,
    );

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
      drawer: DrawerWidget(token: widget.token, user: _user),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              showSearch(
                context: context,
                delegate: SearchProjects(
                    allProjects: await _projects,
                    token: widget.token,
                    user: _user),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              PopUpFilter.filter(context, _maxPrice, widget.token);
            },
            icon: const Icon(
              Icons.tune_rounded,
            ),
          ),
        ],
      ),
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
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          top:
                              0), // change the default top padding of a ListView
                      itemCount: _user?.permissionLevel == 3
                          ? snapshot.data!.length + 1
                          : snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Display the projects in Cards
                        // If the user is an admin present the create project CARD
                        if (_user?.permissionLevel == 3) {
                          if (index == 0) {
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              child: InkWell(
                                child: const Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 50,
                                  ),
                                ),
                                // create new project
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/proposalCreate',
                                      arguments:
                                          UserArguments(widget.token, _user));
                                },
                              ),
                            );
                          }
                          index -= 1;
                        }
                        double neededValue = snapshot.data![index].finalValue -
                            snapshot.data![index].totalFinanced;
                        neededValue > _maxPrice
                            ? _maxPrice = neededValue
                            : _maxPrice = _maxPrice;
                        return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    snapshot.data![index], _user)),
                          ),
                        );
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
      bottomNavigationBar: _user?.permissionLevel != 3
          ? BottomNavigationBarWidget(
              selectedIndex: 1,
              token: widget.token,
              user: _user,
            )
          : null,
    );
  }
}
