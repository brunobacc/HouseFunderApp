import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/project.dart';

import '../../widgets/project_details.dart';

/// search projects by title and description
class SearchProjects extends SearchDelegate {
  final List<Project> allProjects;

  SearchProjects({required this.allProjects});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          size: 36,
        ),
        onPressed: () {
          if (query == '') {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        size: 36,
      ),
      onPressed: () => {
        close(context, null),
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Project> filteredProjects = allProjects.where((p) {
      return p.title.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: filteredProjects.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.only(
                  top: 0), // change the default top padding of a ListView
              itemCount: filteredProjects.length,
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
                              'assets/images/${filteredProjects[i].image}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                filteredProjects[i].location,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${filteredProjects[i].finalValue.toString()}€',
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            filteredProjects[i].description,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProjectDetails(
                          project: filteredProjects[i],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('Zero projects to show!'),
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Project> filteredProjects = allProjects.where((p) {
      return p.title.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: filteredProjects.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.only(
                  top: 0), // change the default top padding of a ListView
              itemCount: filteredProjects.length,
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
                              'assets/images/${filteredProjects[i].image}'),
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                filteredProjects[i].location,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${filteredProjects[i].finalValue.toString()}€',
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            filteredProjects[i].description,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProjectDetails(
                          project: filteredProjects[i],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('Zero projects to show!'),
            ),
    );
  }
}
