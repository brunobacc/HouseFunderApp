import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../modules/projects.dart';

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Row(
              children: [
                // User Image
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Icon(Icons.accessibility_rounded),
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
              padding: EdgeInsets.only(top: 30),
              child: Table(
                border: TableBorder.all(
                  width: 1,
                  borderRadius: BorderRadius.circular(20),
                ),
                children: [
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: const [
                            Text('Financing'),
                            Text('Done'),
                            Text('2'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: const [
                            Text('Total Amount'),
                            Text('Financed'),
                            Text('250€'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Financed Projects'),
              ),
            ),
            // Projects
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.projects.count > 0
                    ? ListView.builder(
                        itemCount: widget.projects.count,
                        itemBuilder: (BuildContext context, int i) {
                          // CARDS
                          return Card(
                            child: ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
      ),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 2),
    );
  }
}
