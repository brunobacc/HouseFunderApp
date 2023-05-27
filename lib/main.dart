import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';
import 'package:projeto_computacao_movel/widgets/profile.dart';
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
        primaryColor: Color(0xFFB89888),
        cardColor: Color(0x00AFB1B6),
        textTheme: TextTheme(bodyLarge: TextStyle()),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown, //stand by
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePageFinancer(),
        '/shop': (context) => ShopPageWidget(),
        '/profile': (context) => Profile()
      },
    );
  }
}
