import 'package:flutter/material.dart';
import '../modules/product.dart';
import '../data/products.dart';

class ProductPopUp {
  BuildContext context;

  ProductPopUp(this.context);


  static void create(BuildContext context) {
    var popUp = AlertDialog(
      content: Create(),
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

  /*static void update(
      BuildContext context, List<Team> teams, String? email, Player player) {
    var popUp = AlertDialog(
      content: Update(teams: teams, email: email, player: player),
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

  static void delete(BuildContext context, Player player, String? email) {
    Navigator.of(context).pop();
    var popUp = AlertDialog(
      content: Delete(
        player: player,
        email: email,
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }

  static void info(
      BuildContext context, String title, String message, String? email) {
    Navigator.of(context).pop();
    var popUp = AlertDialog(
      content: Info(title: title, message: message, email: email),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }*/
}

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

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
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter a title';
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter a description';
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
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
                decoration: InputDecoration(labelText: 'Image'),
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'Please enter an image';
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context); // Close the popup
                    },
                  ),
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Product newProduct = Product(
                          productId: 0,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: int.parse(_priceController.text),
                          image: _imageController.text,
                        );

                        Products.addProduct(newProduct).then((_) {
                          Navigator.pop(context); // Close the popup
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Product added successfully'),
                            ),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
      ),
    );
  }
}
