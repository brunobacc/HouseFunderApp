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
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.all(
                0), // used to make the icon with centered inside the button
            icon: const Icon(
              Icons.menu,
              size: 36,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5DFDF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            hintText: 'Search for a project',
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
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
              child: IconButton(
                padding: const EdgeInsets.all(
                    0), // used to make the icon with centered inside the button
                icon: const Icon(
                  Icons.tune,
                  size: 30,
                ),
                onPressed: () => null,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            // Projects
            Expanded(
              child: widget.projects.count > 0
                  ? ListView.builder(
                      padding: const EdgeInsets.only(
                          top:
                              0), // change the default top padding of a ListView
                      itemCount: widget.projects.count,
                      itemBuilder: (BuildContext context, int i) {
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
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        widget.projects.list[i].location,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        '${widget.projects.list[i].finalValue.toString()}€',
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
                                    widget.projects.list[i].description,
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
      ),
    );
  }
}
