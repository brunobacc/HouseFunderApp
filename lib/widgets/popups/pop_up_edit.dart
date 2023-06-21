import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/edit_profile_request.dart';
import 'package:projeto_computacao_movel/modules/user.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_up_info.dart';
import '../utils/validations.dart';

class PopUpEdit {
  BuildContext context;

  PopUpEdit(this.context);

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
}

class Edit extends StatelessWidget {
  final User? user;
  final String? token;
  Edit({required this.user, required this.token, super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = user!.username;
    emailController.text = user!.email;
    imageController.text = user!.image;
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
                  if (value == null) {
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
              Row(
                children: [
                  const TextButton(
                    onPressed: null,
                    child: Icon(
                      Icons.upload,
                      size: 36,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      imageController.text,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // create a new variable to store the bool received from the "DeletePlayer" function
                        Future<bool> editProfile =
                            EditProfileRequest.editProfile(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                                imageController.text,
                                token,
                                user!.userId);
                        // when playerDeleted receives a bool value, it will present an information popUp
                        editProfile.then(
                          (value) {
                            value
                                ? PopUpInfo.info(context, 'Sucess',
                                    'The player was edited!', token)
                                : PopUpInfo.info(
                                    context,
                                    'Error',
                                    'Something happen when it was editing the profile!',
                                    token);
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
