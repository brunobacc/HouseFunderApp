import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/partnership.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';

import '../../data/projects.dart';
import '../../data/users.dart';
import '../../modules/project.dart';
import '../../modules/user.dart';

class PopUpValidation {
  BuildContext context;
  PopUpValidation(this.context);

  static void validate({
    required BuildContext context,
    required String? token,
    required Project project,
    required User? user,
  }) {
    var popUp = AlertDialog(
      content: Validate(
        token: token,
        project: project,
        user: user,
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      context: context,
      builder: (_) => popUp,
    );
  }
}

class Validate extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;

  const Validate({
    required this.project,
    required this.token,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  late Future<List<Partnership>> _partnerships;
  final TextEditingController _motiveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _partnerships = Users.fetchPartnerships();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.project.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://housefunderstorage.blob.core.windows.net/projects/${widget.project.image}',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder(
                  future: _partnerships,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final teste = snapshot.data!
                          .where(
                            (p) => p.id == widget.project.partnershipId,
                          )
                          .first;
                      return Text(
                        'Partnership: ${teste.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
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
              Text(
                widget.project.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.user?.permissionLevel == 3) {
                        Future<bool> projectStatus = Projects.validateProject(
                            widget.token, 5, widget.project.projectId);
                        projectStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The project was accepted!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the project was being accepted!',
                                    widget.token,
                                  );
                          },
                        );
                      } else {
                        Future<bool> projectStatus = Projects.validateProject(
                            widget.token, 2, widget.project.projectId);
                        projectStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The project was accepted!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the project was being accepted!',
                                    widget.token,
                                  );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Accept',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Decline',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: () {
                      Future<bool> projectStatus = Projects.validateProject(
                          widget.token, 1, widget.project.projectId);
                      projectStatus.then(
                        (value) {
                          value
                              ? PopUpInfo.info(
                                  context,
                                  'Success',
                                  'The project was declined!',
                                  widget.token,
                                )
                              : PopUpInfo.info(
                                  context,
                                  'Error',
                                  'Something happened when the project was being declined!',
                                  widget.token,
                                );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
