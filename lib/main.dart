import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';
import 'package:projeto_computacao_movel/widgets/profile.dart';
import 'package:projeto_computacao_movel/widgets/proposal_page.dart';
import 'package:projeto_computacao_movel/widgets/shop_page_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF867563),
        cardColor: const Color(0xFFE5DFDF),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 28),
          titleSmall: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // trocar por bold
          bodyLarge: TextStyle(fontSize: 24),
          bodyMedium: TextStyle(fontSize: 19),
          bodySmall: TextStyle(fontSize: 16),
          headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 22, color: Colors.white),
          labelMedium: TextStyle(fontSize: 18, color: Colors.white),
          labelSmall: TextStyle(fontSize: 16, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFD9C5AD),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown, //stand by
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePageFinancer(),
        '/shop': (context) => ShopPageWidget(),
        '/profile': (context) => Profile(),
        '/proposal': (context) => ProposalPage()
      },
    );
  }
}
