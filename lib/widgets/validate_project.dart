import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import '../modules/user.dart';

class ProjectDetailsValidate extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;
  const ProjectDetailsValidate(
      {required this.project,
      required this.token,
      required this.user,
      super.key});

  static const String routeName = '/projectDetailsValidate';

  @override
  State<ProjectDetailsValidate> createState() => _ProjectDetailsValidateState();
}

class _ProjectDetailsValidateState extends State<ProjectDetailsValidate> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://housefunderstorage.blob.core.windows.net/projects/${widget.project.image}',
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
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
                              backgroundColor: Colors.black45,
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.user?.permissionLevel == 3) {
                          Projects.validateProject(
                              widget.token, 5, widget.project.projectId);
                          print(widget.project.statusId);
                          Navigator.pop(context);
                        } else {
                          Projects.validateProject(
                              widget.token, 2, widget.project.projectId);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Accept',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value != null) {
                          return null;
                        }
                        return 'Please enter a description';
                      },
                    ),
                    child: Text(
                      'Decline',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
