import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final String? token;
  final int? level;
  const BottomNavigationBarWidget(
      {required this.selectedIndex,
      required this.token,
      required this.level,
      super.key});

  @override
  Widget build(BuildContext context) {
    List<GButton> getTabs() {
      if (level == 2) {
        return [
          GButton(
            icon: Icons.verified,
            text: 'Verify',
            textStyle: Theme.of(context).textTheme.labelMedium,
          ),
          GButton(
              icon: Icons.home,
              text: 'Home',
              textStyle: Theme.of(context).textTheme.labelMedium),
          GButton(
              icon: Icons.history,
              text: 'History',
              textStyle: Theme.of(context).textTheme.labelMedium),
        ];
      } else {
        return [
          GButton(
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
        ];
      }
    }

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
              if (level == 2) {
                Navigator.pushNamed(context, '/verify', arguments: token);
              }
              token != null
                  ? Navigator.pushNamed(context, '/shop', arguments: token)
                  : Navigator.pushNamed(context, '/login');
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/',
                  arguments: HomePageArguments(false, false, false, false,
                      false, null, null, null, 0, token));
            }
            if (index == 2) {
              if (level == 2) {
                Navigator.pushNamed(context, '/history', arguments: token);
              }
              token != null
                  ? Navigator.pushNamed(context, '/profile', arguments: token)
                  : Navigator.pushNamed(context, '/login');
            }
          },
          tabs: getTabs(),
        ),
      ),
    );
  }
}
