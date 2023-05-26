import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/styling/theme.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';

void main() {
  runApp(const MyApp());
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xFFB89888,
    const <int, Color>{
      50: Color(0xFFB89888), //10%
    },
  );
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
      home: HomePageFinancer(),
    );
  }
}
