import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';
import '../../data/products.dart';
import '../../data/projects.dart';
import '../../modules/partnership.dart';
import '../../modules/product.dart';
import '../../modules/user.dart';

class PopUpsAdmin {
  BuildContext context;

  PopUpsAdmin(this.context);

  static void createAdmin(BuildContext context) {
    var popUp = AlertDialog(
      content: const CreateAdmin(),
      contentPadding: EdgeInsets.zero,
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

  static void deleteProduct(
      {required BuildContext context,
      required Product? product,
      required String? token}) {
    var popUp = AlertDialog(
      content: DeleteProduct(
        product: product,
        token: token,
      ),
      contentPadding: EdgeInsets.zero,
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

  static void createProduct(BuildContext context) {
    var popUp = AlertDialog(
      content: const CreateProduct(),
      contentPadding: EdgeInsets.zero,
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

  static void editProduct(
      {required BuildContext context,
      required Product? product,
      required String? token}) {
    var popUp = AlertDialog(
      content: EditProduct(product: product, token: token),
      contentPadding: EdgeInsets.zero,
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

  static void editProject({
    required BuildContext context,
    required User? user,
    required String? token,
    required Project project,
  }) {
    var popUp = AlertDialog(
      content: EditProject(
        token: token,
        user: user,
        project: project,
      ),
      contentPadding: EdgeInsets.zero,
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

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({super.key});

  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter a name';
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'email'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter a email';
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter a password';
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter an image';
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context); // Close the popup
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Users.register(
                                _nameController.text,
                                _emailController.text,
                                _passwordController.text,
                                3)
                            .then((_) {
                          Navigator.pop(context); // Close the popup
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Administrator added successfully'),
                            ),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to add admin'),
                            ),
                          );
                        });
                      }
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

class EditProduct extends StatefulWidget {
  final Product? product;
  final String? token;
  const EditProduct({required this.product, required this.token, super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceContorller = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _priceContorller.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a Title';
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a Description';
              },
            ),
            TextFormField(
              controller: _priceContorller,
              decoration: const InputDecoration(labelText: 'Price'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a price';
              },
            ),
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Value'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a value';
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter an image';
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                ),
                ElevatedButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Products.updateProduct(
                              _titleController.text,
                              _descriptionController.text,
                              widget.product!.productId,
                              int.parse(_priceContorller.text),
                              _imageController.text,
                              double.parse(_valueController.text),
                              widget.token)
                          .then((_) {
                        Navigator.pop(context); // Close the popup
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product edited  successfully'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to edit product'),
                          ),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteProduct extends StatefulWidget {
  final Product? product;
  final String? token;
  const DeleteProduct({required this.product, required this.token, super.key});

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(
          "Are you sure?",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          "That you want to delete this notification.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Products.delete(widget.token, widget.product!.productId);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
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
      ),
    );
  }
}

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a title';
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter a description';
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null) {
                  return null;
                }
                if (double.tryParse(value!) != null) {
                  return 'Invalid price';
                }
                return 'Please enter a price';
              },
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image'),
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return 'Please enter an image';
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Product newProduct = Product(
                        productId: 0,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        price: int.parse(_priceController.text),
                        image: _imageController.text,
                        value: double.tryParse(_valueController.text),
                        active: true,
                      );

                      Products.addProduct(newProduct).then((_) {
                        Navigator.pop(context); // Close the popup
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product added successfully'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to add product'),
                          ),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditProject extends StatefulWidget {
  final String? token;
  final User? user;
  final Project project;
  const EditProject(
      {required this.token,
      required this.user,
      required this.project,
      super.key});

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
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
    titleController.text = widget.project.title;
    descriptionController.text = widget.project.description;
    locationController.text = widget.project.location;
    valueNeededController.text = widget.project.finalValue.toString();
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
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
                            height: 150,
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
                      Future<bool> proposalStatus = Projects.editProject(
                          2,
                          selectedPartnership!,
                          widget.user!.userId,
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
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.bodyMedium,
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
