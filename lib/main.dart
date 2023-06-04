import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';
import 'package:projeto_computacao_movel/widgets/profile.dart';
import 'package:projeto_computacao_movel/widgets/proposal_page.dart';
import 'package:projeto_computacao_movel/widgets/shop_page_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 36),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF867563),
        cardColor: const Color(0xFFE5DFDF),
        brightness: Brightness.light,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 28, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 24, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 19, color: Colors.black),
          bodySmall: TextStyle(fontSize: 17, color: Colors.black),
          headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 18, color: Colors.white),
          labelMedium: TextStyle(fontSize: 16, color: Colors.white),
          labelSmall: TextStyle(fontSize: 13, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFD9C5AD),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF212121),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: const Color(0xFF212121),
        primaryColor: const Color(0xFF453E37),
        cardColor: const Color(0xFF3C3C3C),
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 28, color: Colors.white),
          titleSmall: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 24, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 19, color: Colors.white),
          bodySmall: TextStyle(fontSize: 17, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontSize: 18, color: Colors.black),
          labelMedium: TextStyle(fontSize: 16, color: Colors.black),
          labelSmall: TextStyle(fontSize: 13, color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFFD9C5AD),
            ),
          ),
        ),
      ),
      themeMode: _themeMode,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePageFinancer(),
        '/shop': (context) => ShopPageWidget(),
        '/profile': (context) => Profile(),
        '/proposal': (context) => ProposalPage(),
      },
    );
  }
}
