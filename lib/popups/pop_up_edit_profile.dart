import 'package:flutter/material.dart';

class PopUpEditProfile extends StatefulWidget {
  const PopUpEditProfile({super.key});

  @override
  State<PopUpEditProfile> createState() => _PopUpEditProfileState();
}

class _PopUpEditProfileState extends State<PopUpEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(80, 180, 80, 180),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                const TextButton(
                  onPressed: null,
                  child: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Username:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: TextEditingController(text: 'BrunoBACC'),
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
              controller: TextEditingController(text: 'a24603@alunos.ipca.pt'),
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
              controller: TextEditingController(text: '***********'),
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
              controller: TextEditingController(text: '***********'),
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
              padding: const EdgeInsets.only(top: 20),
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
