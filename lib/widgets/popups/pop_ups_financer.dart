import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_computacao_movel/data/edit_profile_request.dart';
import 'package:projeto_computacao_movel/modules/user.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';
import '../../data/finance_project.dart';
import '../../data/images.dart';
import '../../data/queries/financers_query.dart';
import '../../modules/project.dart';
import '../../modules/project_financed.dart';
import '../../modules/queries/financer_query.dart';
import '../utils/validations.dart';

class PopUpsFinancer {
  BuildContext context;

  PopUpsFinancer(this.context);

  static void edit(
      {required BuildContext context,
      required User? user,
      required String? token}) {
    var popUp = AlertDialog(
      content: Edit(
        user: user,
        token: token,
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
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

  static void ediImage(
      {required BuildContext context,
      required User? user,
      required String? token}) {
    var popUp = AlertDialog(
      content: EditImage(
        user: user,
        token: token,
      ),
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
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

  static void financedProjects({
    required BuildContext context,
    required String? token,
    required ProjectFinanced project,
  }) {
    var popUp = AlertDialog(
      content: FinancedProjects(
        token: token,
        project: project,
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

  static void finance(
      BuildContext context, Project project, String? token, User? user) {
    var popUp = AlertDialog(
      content: Finance(project: project, token: token, user: user),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }
}

class Edit extends StatefulWidget {
  final User? user;
  final String? token;
  Edit({required this.user, required this.token, super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = widget.user!.username;
    emailController.text = widget.user!.email;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Text(
                'Username:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: usernameController,
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Fill the Username';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Email:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: emailController,
                validator: (value) {
                  if (value != null && !value.isValidEmail) {
                    return 'Email not valid!';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Password:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: passwordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Repeat Password:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: repeatPasswordController,
                validator: (value) {
                  if (passwordController.text != value) {
                    return 'Passwords don\'t match';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Image:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // create a new variable to store the bool received from the "EditProfileRequest" function
                        Future<bool> editProfile =
                            EditProfileRequest.editProfile(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                                widget.token,
                                widget.user!.userId);

                        // when editProfile receives a bool value, it will present an information popUp
                        editProfile.then(
                          (value) {
                            value
                                ? PopUpInfo.info(context, 'Sucess',
                                    'The player was edited!', widget.token)
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happen when it was editing the profile!',
                                    widget.token);
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill input!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Save',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditImage extends StatefulWidget {
  final User? user;
  final String? token;
  const EditImage({required this.user, required this.token, super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            //if user click this button, user can upload image from gallery
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            child: Row(
              children: [
                Icon(Icons.image),
                Text('From Gallery'),
              ],
            ),
          ),
          ElevatedButton(
            //if user click this button. user can upload image from camera
            onPressed: () {
              getImage(ImageSource.camera);
            },
            child: Row(
              children: [
                Icon(Icons.camera),
                Text('From Camera'),
              ],
            ),
          ),
          image != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      //to show image, you type like this.
                      File(image!.path),
                      fit: BoxFit.fitHeight,
                      height: 100,
                    ),
                  ),
                )
              : Text(
                  "Select an Image!",
                  style: TextStyle(fontSize: 20),
                ),
          ElevatedButton(
            onPressed: () {
              if (image != null) {
                Future<bool> editProfileStatus =
                    Images.uploadImage(File(image!.path), widget.user!.userId);
                // when playerDeleted receives a bool value, it will present an information popUp
                editProfileStatus.then(
                  (value) {
                    value
                        ? PopUpInfo.info(
                            context,
                            'Success',
                            'The image was updated!',
                            widget.token,
                          )
                        : PopUpInfo.info(
                            context,
                            'Error',
                            'Something happen when it was uploding the image!',
                            widget.token,
                          );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Error!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        'Select an image or click outside the PopUp',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class FinancedProjects extends StatefulWidget {
  final ProjectFinanced project;
  final String? token;

  const FinancedProjects(
      {required this.project, required this.token, super.key});

  @override
  State<FinancedProjects> createState() => _FinancedProjectsState();
}

class _FinancedProjectsState extends State<FinancedProjects> {
  late Future<List<FinancerQuery>> _financers;

  @override
  void initState() {
    super.initState();
    _financers = FinancersQuery.fetchNext(widget.project.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(
                  'assets/images/projects/${widget.project.image}',
                ),
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
                            valueColor:
                                const AlwaysStoppedAnimation(Color(0xFF867563)),
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
                                      child: Image.asset(
                                        'assets/images/avatars/${snapshot.data![index].image}',
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
    );
  }
}

class Finance extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;
  const Finance(
      {required this.project,
      required this.token,
      required this.user,
      super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  TextEditingController amountFinancedController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Financing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Amount:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountFinancedController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 5)
                          .toString();
                }),
                child: const Text('5€'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 10)
                          .toString();
                }),
                child: const Text('10€'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 20)
                          .toString();
                }),
                child: const Text('20€'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Payment Methods:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  // create a new variable to store the bool received from the "DeletePlayer" function
                  Future<bool> financeStatus = FinanceProject.financeProject(
                    widget.project,
                    double.parse(amountFinancedController.text),
                    widget.token,
                    widget.user,
                  );
                  // when playerDeleted receives a bool value, it will present an information popUp
                  financeStatus.then(
                    (value) {
                      value
                          ? PopUpInfo.info(
                              context,
                              'Sucess',
                              'The project was financed!',
                              widget.token,
                            )
                          : PopUpInfo.info(
                              context,
                              'Error',
                              'Something happen when it was financing the project!',
                              widget.token,
                            );
                    },
                  );
                },
                child: Image.asset(
                  'assets/images/methods/multibanco.png',
                  height: 60,
                  width: 60,
                ),
              ),
              InkWell(
                onTap: () => null,
                child: Image.asset(
                  'assets/images/methods/mbWay.png',
                  height: 60,
                  width: 60,
                ),
              ),
              InkWell(
                onTap: () => null,
                child: Image.asset(
                  'assets/images/methods/PayPal.png',
                  height: 60,
                  width: 60,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
