import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/user.dart';

class EditPopUp {
  BuildContext context;

  EditPopUp(this.context);

  static void edit(
      {required BuildContext context,
      required User? user,
      required String? token}) {
    var popUp = AlertDialog(
      content: Edit(
        user: user,
      ),
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
  Edit({required this.user, super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = user!.username;
    emailController.text = user!.email;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(10),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Edit Profile',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Username:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: usernameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Email:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Password:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: passwordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Repeat Password:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: repeatPasswordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Image:',
                style: Theme.of(context).textTheme.titleSmall,
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
                    'Icon_Image.....',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
