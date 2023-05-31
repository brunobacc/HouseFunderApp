import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('null'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
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
            title: const Text(
              'Propose',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.edit_document),
            onTap: () =>  Navigator.pushNamed(context, '/proposal'),
          ),
          const ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.notifications),
          ),
          const ListTile(
            title: Text(
              'Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text(
              'About Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.info),
          ),
          const ListTile(
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
