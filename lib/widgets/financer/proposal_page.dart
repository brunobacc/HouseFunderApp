import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_computacao_movel/data/projects.dart';
import '../../data/users.dart';
import '../../modules/partnership.dart';
import '../popups/pop_up_info.dart';

class ProposalPage extends StatefulWidget {
  final String? token;
  const ProposalPage({required this.token, super.key});

  static const String routeName = '/proposal';

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  XFile? image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController valueNeededController = TextEditingController();
  late Future<List<Partnership>> _partnerships;
  int? selectedPartnership;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    _partnerships = Users.fetchPartnerships();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Proposal',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Insert the title!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Insert the description!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: locationController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Location",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Insert the location!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: valueNeededController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Value Needed",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Insert the value!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<Partnership>>(
                future: _partnerships,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      isExpanded: true,
                      hint: Text(
                        'Partnership',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: selectedPartnership,
                      items: snapshot.data!
                          .map((p) => DropdownMenuItem(
                                value: p.id,
                                child: Text(
                                  p.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        selectedPartnership = value;
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Image: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.upload,
                      size: 30,
                    ),
                  ),
                ],
              ),
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            //to show image, you type like this.
                            File(image!.path),
                            fit: BoxFit.fitHeight,
                            height: 200,
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Select an Image!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                    ),
                  ),
                  onPressed: () {
                    if (image != null) {
                      Future<bool> proposalStatus = Projects.proposeProject(
                          selectedPartnership!,
                          locationController.text,
                          File(image!.path),
                          titleController.text,
                          descriptionController.text,
                          int.parse(valueNeededController.text));
                      // when playerDeleted receives a bool value, it will present an information popUp
                      proposalStatus.then(
                        (value) {
                          value
                              ? PopUpInfo.info(
                                  context,
                                  'Success',
                                  'The project was proposed!',
                                  widget.token,
                                )
                              : PopUpInfo.info(
                                  context,
                                  'Error',
                                  'Something happened when the project was being processed!',
                                  widget.token,
                                );
                        },
                      );
                    }
                  },
                  child: const Text('Propose'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
