import 'package:flutter/material.dart';
import '../../main.dart';

class DrawerWidget extends StatefulWidget {
  final String? token;
  const DrawerWidget({this.token, super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

bool dark = false;

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          widget.token != null
              ? SizedBox(
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
                )
              : const SizedBox(
                  height: 30,
                ),
          ListTile(
              title: Text(
                'Propose',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              leading: const Icon(Icons.edit_document),
              onTap: () => widget.token != null
                  ? Navigator.pushNamed(context, '/proposal')
                  : Navigator.pushNamed(context, '/login')),
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
                      if (dark == true) {
                        MyApp.of(context).changeTheme(ThemeMode.dark);
                      } else {
                        MyApp.of(context).changeTheme(ThemeMode.light);
                      }
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
          widget.token != null
              ? ListTile(
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/',
                      arguments: null,
                    );
                  },
                )
              : ListTile(
                  title: Text(
                    'LogIn',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  leading: const Icon(Icons.login),
                  onTap: () => Navigator.pushNamed(context, '/login'),
                ),
        ],
      ),
    );
  }
}
