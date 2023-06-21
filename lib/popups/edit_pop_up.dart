import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/user.dart';

class EditPopUp {
  BuildContext context;

  EditPopUp(this.context);

  static void edit({
    required BuildContext context,
    /*required User? user,
      required String? token*/
  }) {
    var popUp = AlertDialog(
      content: Edit(
          // user: user,
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
  //final User? user;
  Edit({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // usernameController.text = user!.username;
    // emailController.text = user!.email;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(10),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Username:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: usernameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Email:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Password:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: passwordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Repeat Password:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: repeatPasswordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Image:',
                style: Theme.of(context).textTheme.subtitle1,
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
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
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
                      // Adicione sua lógica aqui
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                      'Save',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
