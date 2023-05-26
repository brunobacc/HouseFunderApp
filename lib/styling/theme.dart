import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/home_page_financer.dart';

class MyAppTheme extends StatelessWidget {
  const MyAppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFB89888),
        fontFamily: 'Calibri',
      ),
    );
  }
}
