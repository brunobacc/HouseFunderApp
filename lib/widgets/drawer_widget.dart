import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 220,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.accessibility_rounded),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('BrunoBACC',
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Text('a24603@alunos.ipca.pt',
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Propose',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: const Icon(Icons.edit_document),
            onTap: () => Navigator.pushNamed(context, '/proposal'),
          ),
          ListTile(
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: const Icon(Icons.notifications),
          ),
          ExpansionTile(
            title: Text('Options',
                style: Theme.of(context).textTheme.headlineMedium),
            leading: const Icon(Icons.settings),
            children: [
              ListTile(
                title: Text('Dark Mode',
                    style: Theme.of(context).textTheme.bodySmall),
                trailing: Switch(
                  value: dark,
                  onChanged: (_) => setState(
                    () {
                      dark = !dark;
                    },
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              'About Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: const Icon(Icons.info),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
