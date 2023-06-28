import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import 'package:projeto_computacao_movel/modules/admnistrator.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';
import 'package:projeto_computacao_movel/widgets/utils/validations.dart';
import '../../data/products.dart';
import '../../modules/product.dart';
import '../../modules/user.dart';

class PopUpsAdmin {
  BuildContext context;

  PopUpsAdmin(this.context);

  static void createAdmin(BuildContext context, String? token) {
    var popUp = AlertDialog(
      content: CreateAdmin(
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

  static void editAdmin(
      {required BuildContext context,
      required Administrator user,
      required String? token}) {
    var popUp = AlertDialog(
      content: EditAdmin(token: token, user: user),
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

  static void createProduct(
    BuildContext context,
    String? token,
  ) {
    var popUp = AlertDialog(
      content: CreateProduct(
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

  static void editProduct(
      {required BuildContext context,
      required Product product,
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

/*  static void editProject({
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
  }*/
}

class CreateAdmin extends StatefulWidget {
  final String? token;
  const CreateAdmin({required this.token, super.key});

  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

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
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: SingleChildScrollView(
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
                    'Create',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextFormField(
                  controller: usernameController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && !value.isValidName) {
                      return 'Please insert an Username!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && !value.isValidEmail) {
                      return 'Email not valid!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // update the state
                        setState(
                          () {
                            _passwordVisible = !_passwordVisible;
                          },
                        );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != null && !value.isValidPassword) {
                      return 'Password not valid!';
                    }
                    return null;
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
                      if (_formKey.currentState!.validate() && image != null) {
                        Future<bool> administratorStatus =
                            Users.createAdministrator(
                          usernameController.text,
                          emailController.text,
                          passwordController.text,
                          File(image!.path),
                        );
                        // when administratorStatus receives a bool value, it will present an information popUp
                        administratorStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The administrator was created!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the administrator was being created!',
                                    widget.token,
                                  );
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
                    child: Text(
                      'Create',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditAdmin extends StatefulWidget {
  final String? token;
  final Administrator? user;
  const EditAdmin({required this.token, required this.user, super.key});

  @override
  State<EditAdmin> createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

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
    usernameController.text = widget.user!.name;
    emailController.text = widget.user!.email;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: SingleChildScrollView(
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
                  controller: usernameController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && !value.isValidName) {
                      return 'Please insert an Username!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && !value.isValidEmail) {
                      return 'Email not valid!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // update the state
                        setState(
                          () {
                            _passwordVisible = !_passwordVisible;
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: repeatPasswordController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  obscureText: _repeatPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Repeat Password",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // update the state
                        setState(
                          () {
                            _repeatPasswordVisible = !_repeatPasswordVisible;
                          },
                        );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (passwordController.text !=
                        repeatPasswordController.text) {
                      return 'Passwords don\'t match!';
                    }
                    return null;
                  },
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
                      if (_formKey.currentState!.validate()) {
                        Future<bool> administratorStatus =
                            Users.editAdministrator(
                          usernameController.text,
                          emailController.text,
                          passwordController.text,
                          File(image!.path),
                          widget.user!.userId,
                        );
                        // when administratorStatus receives a bool value, it will present an information popUp
                        administratorStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The administrator was edited!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the administrator was being edited!',
                                    widget.token,
                                  );
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
      ),
    );
  }
}

class EditProduct extends StatefulWidget {
  final Product product;
  final String? token;
  const EditProduct({required this.product, required this.token, super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceContorller = TextEditingController();
  final TextEditingController valueController = TextEditingController();

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
    titleController.text = widget.product.title;
    descriptionController.text = widget.product.description;
    priceContorller.text = widget.product.price.toString();
    valueController.text = widget.product.value.toString();

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: SingleChildScrollView(
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
                  controller: priceContorller,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Price",
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
                      return 'Insert the Price!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: valueController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Value",
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
                        Future<bool> productStatus = Products.editProduct(
                          titleController.text,
                          descriptionController.text,
                          File(image!.path),
                          int.parse(priceContorller.text),
                          int.parse(valueController.text),
                          widget.product.productId,
                        );
                        // when productStatus receives a bool value, it will present an information popUp
                        productStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The product was created!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the product was being created!',
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
      ),
    );
  }
}

class CreateProduct extends StatefulWidget {
  final String? token;
  const CreateProduct({required this.token, super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceContorller = TextEditingController();
  final TextEditingController valueController = TextEditingController();

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
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: SingleChildScrollView(
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
                    'Create',
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
                  controller: priceContorller,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Price",
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
                      return 'Insert the Price!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: valueController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Value",
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
                        Future<bool> productStatus = Products.createProduct(
                          titleController.text,
                          descriptionController.text,
                          File(image!.path),
                          int.parse(priceContorller.text),
                          int.parse(valueController.text),
                        );
                        // when productStatus receives a bool value, it will present an information popUp
                        productStatus.then(
                          (value) {
                            value
                                ? PopUpInfo.info(
                                    context,
                                    'Success',
                                    'The product was created!',
                                    widget.token,
                                  )
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happened when the product was being created!',
                                    widget.token,
                                  );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Create',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class EditProject extends StatefulWidget {
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
*/