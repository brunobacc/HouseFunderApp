import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/popups/pop_up_edit_profile.dart';
import 'package:projeto_computacao_movel/widgets/bottom_navigation_bar_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../data/projects.dart';
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
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
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ),
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
            Padding(
              // give space between the top bar(menu icon and title) and user information
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  // User Image
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    child: const Icon(Icons.accessibility_rounded),
                  ),
                  // Info about the user (Username and Email) and button to edit profile
                  SizedBox(
                    // used the size box, because the column is not taking up all the space on the main axis within the row
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'BrunoBACC',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'a24603@alunos.ipca.pt',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            child: Text(
                              'Edit Profile',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onPressed: () async {
                              double? val = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    const SingleChildScrollView(
                                  // use this widget, so when using the keyboard, don't compress the pop-up window by oversizing the data inside
                                  child: PopUpEditProfile(),
                                ),
                              );
                            },
                          ),
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
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xFFE5DFDF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: [
                            Text(
                              'Financing',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Done',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '2',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: [
                            Text(
                              'Total Amount',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Financed',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '250€',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: [
                            Text(
                              'Accepted',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Projects',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '5',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
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
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Financed Projects',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            // Projects
            /*Expanded(
              child: widget.projects.count > 0
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 10),
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
                                    widget.projects.list[i].title,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 2),
    );
  }
}
