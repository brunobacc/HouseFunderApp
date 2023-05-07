import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/project.dart';

import '../modules/projects.dart';
import '../popups/pop_up1.dart';

class HomePageFinancer extends StatefulWidget {
  late Projects projects;
  late List<bool> _selectedProjects;

  HomePageFinancer({super.key}) {
    projects = Projects();
    _selectedProjects = List<bool>.generate(projects.count, (_) => false);
  }

  @override
  State<HomePageFinancer> createState() => _HomePageFinancerState();
}

class _HomePageFinancerState extends State<HomePageFinancer> {
  List<Project> getSelectedProducts() {
    List<Project> selectedProjects = [];
    for (var i = 0; i < widget.projects.count; i++) {
      if (widget._selectedProjects[i]) {
        selectedProjects.add(widget.projects.list[i]);
      }
    }
    return selectedProjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widgets'),
        actions: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            icon: const Icon(Icons.select_all),
            onPressed: () {
              setState(() {
                widget._selectedProjects = List<bool>.generate(
                    widget.projects.count, (_) => !widget._selectedProjects[0]);
              });
            },
          )
        ],
      ),
      body: Column(children: [
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
                              margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
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
                              )),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(widget.projects.list[i].location),
                                  Text(widget.projects.list[i].finalValue
                                      .toString()),
                                ],
                              ),
                              Text(widget.projects.list[i].description),
                            ],
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
        Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.join_inner),
            label: const Text('Show selected index'),
            onPressed: () {
              PopUp1.popUpType1(context, 'Selected Product',
                  getSelectedProducts().join('\n\n'));
            },
          ),
        ),
      ]),
    );
  }
}
