import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:projeto_computacao_movel/widgets/drawer_widget.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

import '../modules/projects.dart';
import '../popups/pop_up1.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      /* appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30,
        ),
      ),*/

      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: DrawerWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),

          /* Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Icon(Icons.menu),
            ),
          ),*/

          SizedBox(
            height: 20,
          ),

          // search bar

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Container(
                          child: TextButton(
                            child: Icon(Icons.menu),
                            onPressed: () =>
                                _scaffoldKey.currentState?.openDrawer(),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 30,
                      child: Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for a mission',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.filter_2),
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // missions
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
                              margin: const EdgeInsets.fromLTRB(50, 5, 50, 0),
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
      bottomNavigationBar: Container(
        color: Color(0xFFB89888),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Color(0xFFB89888),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.shop,
                text: 'Shop',
              ),
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
