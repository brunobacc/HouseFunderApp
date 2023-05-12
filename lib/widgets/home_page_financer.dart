import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/drawer_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../modules/projects.dart';
import '../popups/pop_up1.dart';

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
      appBar: AppBar(
        title: const Text('Flutter Teste'),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30,
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: DrawerWidget(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.projects.count > 0
                  ? ListView.builder(
                      itemCount: widget.projects.count,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                          child: ListTile(
                            title: Container(
                              margin: const EdgeInsets.fromLTRB(50, 5, 50, 0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
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
    );
  }
}
