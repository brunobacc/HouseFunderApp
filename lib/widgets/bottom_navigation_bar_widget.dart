import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';
import 'package:projeto_computacao_movel/widgets/profile.dart';
import 'package:projeto_computacao_movel/widgets/shop_page_widget.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  int selectedIndex = 0;
  BottomNavigationBarWidget({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFB89888),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Color(0xFFB89888),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          padding: EdgeInsets.all(16),
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
          tabs: const [
            GButton(
              icon: Icons.shop,
              text: 'Shop',
            ),
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
