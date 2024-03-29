import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/profile_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/user_arguments.dart';
import 'package:projeto_computacao_movel/modules/custom_icons.dart';
import 'package:projeto_computacao_movel/modules/user.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final String? token;
  final User? user;
  const BottomNavigationBarWidget(
      {required this.selectedIndex,
      required this.token,
      required this.user,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: GNav(
          backgroundColor: Theme.of(context).primaryColor,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0xFFD9C5AD),
          gap: 8,
          padding: const EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            if (index == selectedIndex) {
              return;
            }
            if (index == 0) {
              if (user?.permissionLevel == 2) {
                Navigator.pushNamed(context, '/validateProposal',
                    arguments: UserArguments(token, user));
              } else {
                token != null
                    ? Navigator.pushNamed(context, '/shop', arguments: token)
                    : Navigator.pushNamed(context, '/login');
              }
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/',
                  arguments: HomePageArguments(false, false, false, false,
                      false, null, null, null, 0, token));
            }
            if (index == 2) {
              if (user?.permissionLevel == 2) {
                Navigator.pushNamed(context, '/history', arguments: token);
              }
              token != null
                  ? Navigator.pushNamed(context, '/profile',
                      arguments: ProfilePageArguments(
                          token: token, level: user!.permissionLevel))
                  : Navigator.pushNamed(context, '/login');
            }
          },
          tabs: [
            user?.permissionLevel == 2
                ? GButton(
                    icon: CustomIcons.document,
                    text: 'Validate',
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  )
                : GButton(
                    icon: Icons.shop,
                    text: 'Shop',
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  ),
            GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle: Theme.of(context).textTheme.labelMedium),
            GButton(
                icon: Icons.person,
                text: 'Profile',
                textStyle: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
