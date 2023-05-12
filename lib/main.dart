import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/styling/theme.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';

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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
        ),
      ),
      home: HomePageFinancer(),
    );
  }
}
