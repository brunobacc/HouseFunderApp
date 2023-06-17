import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/queries/filter_projects.dart';
import 'package:projeto_computacao_movel/modules/home_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/popups/pop_up_filter.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/drawer_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../data/projects.dart';
import '../modules/searchs/search_projects.dart';

class HomePageFinancer extends StatefulWidget {
  final bool newest;
  final bool oldest;
  final bool lowHigh;
  final bool highLow;
  final bool likes;
  final RangeValues? neededPrice;
  final String? region;
  final String? partnership;
  const HomePageFinancer(
      {required this.newest,
      required this.oldest,
      required this.lowHigh,
      required this.highLow,
      required this.likes,
      required this.neededPrice,
      required this.region,
      required this.partnership,
      super.key});

  static const routeName = '/home';

  @override
  State<HomePageFinancer> createState() => _HomePageFinancerState();
}

class _HomePageFinancerState extends State<HomePageFinancer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Project>> _projects;
  late List<Project> projects;
  double maxPrice = 0;

  @override
  void initState() {
    super.initState();
    _projects = FilterProjects.fetchNext(widget.neededPrice?.start,
        widget.neededPrice?.end, widget.region, widget.partnership);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: SizedBox(
          width: 10,
          child: IconButton(
            padding: const EdgeInsets.all(
                0), // used to make the icon with centered inside the button
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showSearch(
                context: context,
                delegate: SearchProjects(
                    allProjects: await Projects.fetchNext(
                        widget.newest,
                        widget.oldest,
                        widget.lowHigh,
                        widget.highLow,
                        widget.likes)),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              PopUpFilter.filter(context, maxPrice);
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
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        double neededValue = snapshot.data![index].finalValue -
                            snapshot.data![index].totalFinanced;
                        neededValue > maxPrice
                            ? maxPrice = neededValue
                            : maxPrice = maxPrice;
                        // Display the projects in Cards
                        return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/${snapshot.data![index].image}'),
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
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProjectDetails(
                                  project: snapshot.data![index],
                                ),
                              ),
                            ),
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
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
      ),
    );
  }
}
