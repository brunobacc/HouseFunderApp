import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/drawer_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../modules/projects.dart';

class HomePageFinancer extends StatefulWidget {
  late Projects projects;
  HomePageFinancer({super.key}) {
    projects = Projects();
  }

  @override
  State<HomePageFinancer> createState() => _HomePageFinancerState();
}

class _HomePageFinancerState extends State<HomePageFinancer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: DrawerWidget(),
      ),
      body: Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                SizedBox(
                  height: 36,
                  width: 36,
                  child: TextButton(
                    child: const Center(
                      child: Icon(Icons.menu),
                    ),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      height: 36,
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: Row(
                        children: const [
                          Center(
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                                border: InputBorder.none,
                                hintText: 'Search for a project',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: TextButton(
                    child: const Center(
                      child: Icon(Icons.filter_1),
                    ),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                ),
              ],
            ),
          ),

          // Projects
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: widget.projects.count > 0
                  ? ListView.builder(
                      itemCount: widget.projects.count,
                      itemBuilder: (BuildContext context, int i) {
                        // Display the projects in Cards
                        return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //side: BorderSide(color: )
                          ),
                          child: ListTile(
                            title: Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/${widget.projects.list[i].image}'),
                                  fit: BoxFit.fill,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 0, 10),
                                      child: Text(
                                        widget.projects.list[i].location,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 30, 10),
                                      child: Text(
                                        '${widget.projects.list[i].finalValue.toString()}€',
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 5),
                                  child: Text(
                                    widget.projects.list[i].description,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProjectDetails(
                                  project: widget.projects.list[i],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Zero products to show!'),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
      ),
    );
  }
}
