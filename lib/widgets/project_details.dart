import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import 'package:projeto_computacao_movel/modules/project_financer.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_ups_admin.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_ups_financer.dart';
import '../modules/user.dart';

class ProjectDetails extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;
  const ProjectDetails(
      {required this.project,
      required this.token,
      required this.user,
      super.key});

  static const String routeName = '/projectDetails';

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late Future<List<ProjectFinancer>> _financers;

  @override
  void initState() {
    super.initState();
    _financers = Projects.fetchProjectFinancers(widget.project.projectId);
  }

  @override
  Widget build(BuildContext context) {
    //print('User1: ${widget.user?.email}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          widget.project.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://housefunderstorage.blob.core.windows.net/projects/${widget.project.image}',
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  /*widget.user?.permissionLevel == 3
                      ? Positioned(
                          top: -10,
                          right: -10,
                          child: Row(
                            children: [
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () => PopUpsAdmin.editProject(
                                  context: context,
                                  user: widget.user,
                                  token: widget.token,
                                  project: widget.project,
                                ),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Are you sure?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      content: Text(
                                        "That you want to delete this project.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Future<bool> projectStatus =
                                                    Projects.delete(
                                                  widget.token,
                                                  widget.project.projectId,
                                                );
                                                // when projectStatus receives a bool value, it will present an information popUp
                                                projectStatus.then(
                                                  (value) {
                                                    value
                                                        ? PopUpInfo.info(
                                                            context,
                                                            'Success',
                                                            'The Project was deleted!',
                                                            widget.token,
                                                          )
                                                        : PopUpInfo.info(
                                                            context,
                                                            'Error',
                                                            'Something happen when it was deleting the project!',
                                                            widget.token,
                                                          );
                                                  },
                                                );
                                              },
                                              child: const Text("Continue"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                //PlayerPopUp.delete(context, player, email),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),*/
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              value: (widget.project.totalFinanced /
                                  widget.project.finalValue),
                              valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF867563)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '${widget.project.totalFinanced.toStringAsFixed(2)}€',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '${(widget.project.finalValue - widget.project.totalFinanced).toStringAsFixed(2)}€',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.user!.permissionLevel != 3
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(
                            35), // make the button expanded
                      ),
                      onPressed: () => widget.token != null
                          ? PopUpsFinancer.finance(context, widget.project,
                              widget.token, widget.user)
                          : Navigator.pushNamed(context, '/login'),
                      child: Text(
                        'Finance',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : const SizedBox(
                      height: 10,
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.project.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${widget.project.finalValue.toStringAsFixed(2)}€',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.project.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Financers',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                child: FutureBuilder(
                  future: _financers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://housefunderstorage.blob.core.windows.net/images/${snapshot.data![index].image}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            snapshot.data![index].username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text('Zero financers to show!'),
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
      ),
    );
  }
}
