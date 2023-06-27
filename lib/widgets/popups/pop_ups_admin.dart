import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import '../../data/products.dart';
import '../../modules/product.dart';

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

    static void deleteProduct({required BuildContext context,
      required Product? product,
      required String? token}) {
    var popUp = AlertDialog(
      content: DeleteProduct(product: product, token: token,),
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

