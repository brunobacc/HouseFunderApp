import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';
import 'package:projeto_computacao_movel/widgets/profile.dart';

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
        primaryColor: Color(0xFFB89888),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown, //stand by
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageFinancer(),
        '/profile': (context) => const Profile()
      },
    );
  }
}
