import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../modules/projects.dart';
import 'drawer_widget.dart';

class Profile extends StatefulWidget {
  late Projects projects;
  Profile({super.key}) {
    projects = Projects();
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: DrawerWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: Column(
          children: [
            Row(
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
                const Expanded(
                  child: Center(
                    child: Text('Profile'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                // User Image
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: const Icon(Icons.accessibility_rounded),
                ),
                // Info about the user (Username and Email) and button to edit profile
                Expanded(
                  child: Column(
                    children: const [
                      Text('BrunoBACC'),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text('a24603@alunos.ipca.pt'),
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Table(
                border: TableBorder.all(
                  width: 1,
                  borderRadius: BorderRadius.circular(20),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5DFDF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: const [
                            Text('Financing'),
                            Text('Done'),
                            Text('2'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: const [
                            Text('Total Amount'),
                            Text('Financed'),
                            Text('250€'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: const [
                            Text('Accepted'),
                            Text('Projects'),
                            Text('5'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Financed Projects'),
              ),
            ),
            // Projects
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: widget.projects.count > 0
                    ? ListView.builder(
                        itemCount: widget.projects.count,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            title: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/${widget.projects.list[i].image}'),
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    color: Colors.black54,
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      '${widget.projects.list[i].title}',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
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
                                      '${widget.projects.list[i].financedValue}',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
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
                          );
                        },
                      )
                    : const Center(
                        child: Text('Zero projects to show!'),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 2),
    );
  }
}
