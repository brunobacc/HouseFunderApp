import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';
import 'package:projeto_computacao_movel/widgets/popups/pop_ups_financer.dart';
import '../../main.dart';
import '../../modules/arguments/user_arguments.dart';
import '../../modules/custom_icons.dart';
import '../../modules/user.dart';

class DrawerWidget extends StatefulWidget {
  final String? token;
  final User? user;
  const DrawerWidget({required this.token, required this.user, super.key});

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
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://housefunderstorage1.blob.core.windows.net/images/${widget.user?.image}',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(widget.user!.username,
                              style: Theme.of(context).textTheme.labelLarge),
                        ),
                        Text(widget.user!.email,
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 30,
                ),
          widget.user?.permissionLevel == 3
              ? ExpansionTile(
                  title: Text('Management',
                      style: Theme.of(context).textTheme.titleSmall),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(CustomIcons.management),
                  ),
                  children: [
                    ListTile(
                      title: Text('Projects',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(CustomIcons.blueprint),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/',
                            arguments: HomePageArguments(
                                false,
                                false,
                                false,
                                false,
                                false,
                                null,
                                null,
                                null,
                                0,
                                widget.token));
                      },
                    ),
                    ListTile(
                      title: Text('Administrators',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(Icons.manage_accounts),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/administrators',
                            arguments:
                                UserArguments(widget.token, widget.user));
                      },
                    ),
                    ListTile(
                      title: Text('Partners',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(Icons.handshake),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/partnerships',
                            arguments:
                                UserArguments(widget.token, widget.user));
                      },
                    ),
                    ListTile(
                      title: Text('Financers',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(CustomIcons.user),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/financers',
                            arguments:
                                UserArguments(widget.token, widget.user));
                      },
                    ),
                    ListTile(
                      title: Text('Products',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(Icons.shopping_cart),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/shopadmin',
                            arguments:
                                UserArguments(widget.token, widget.user));
                      },
                    ),
                    ListTile(
                      title: Text('Proposals',
                          style: Theme.of(context).textTheme.bodySmall),
                      leading: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(CustomIcons.document),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/validateProposal',
                            arguments:
                                UserArguments(widget.token, widget.user));
                      },
                    ),
                  ],
                )
              : const SizedBox(),
          widget.user?.permissionLevel == 1
              ? ListTile(
                  title: Text(
                    'Propose',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.edit_document),
                  ),
                  onTap: () => Navigator.pushNamed(
                        context,
                        '/proposalCreate',
                        arguments: UserArguments(widget.token, widget.user),
                      ))
              : const SizedBox(),
          widget.user?.permissionLevel == 1
              ? ListTile(
                  title: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.notifications),
                  ),
                  onTap: () => PopUpsFinancer.showNotifications(
                      context, widget.token, widget.user))
              : const SizedBox(),
          ExpansionTile(
            title:
                Text('Options', style: Theme.of(context).textTheme.titleSmall),
            leading: IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(Icons.settings),
            ),
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
          widget.user?.permissionLevel != 3
              ? ListTile(
                  title: Text(
                    'About Us',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.info),
                  ),
                )
              : const SizedBox(),
          widget.token != null
              ? ListTile(
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.logout),
                  ),
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  leading: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.login),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/login'),
                ),
        ],
      ),
    );
  }
}
