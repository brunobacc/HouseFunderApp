import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  int selectedIndex = 0;
  BottomNavigationBarWidget({super.key, required this.selectedIndex});

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
          tabBackgroundColor: Color(0xFFD9C5AD),
          gap: 8,
          padding: const EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            if (index == selectedIndex) {
              return;
            }
            if (index == 0) {
              Navigator.pushNamed(context, '/shop');
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/home');
            }
            if (index == 2) {
              Navigator.pushNamed(context, '/profile');
            }
          },
          tabs: [
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
          ],
        ),
      ),
    );
  }
}
