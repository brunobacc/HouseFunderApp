import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/home_page_arguments.dart';
import 'package:projeto_computacao_movel/widgets/filter_page.dart';
import 'package:projeto_computacao_movel/widgets/home_page_financer.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        HomePageArguments? args = settings.arguments as HomePageArguments?;
        return MaterialPageRoute(
          builder: (_) => HomePageFinancer(
            newest: args?.newest ?? false,
            oldest: args?.newest ?? false,
            lowHigh: args?.newest ?? false,
            highLow: args?.newest ?? false,
            likes: args?.newest ?? false,
            neededPrice: args?.neededPrice,
            region: args?.region,
            partnership: args?.partnership,
            maxPrice: args?.maxPrice ?? 0,
          ),
        );
      case FilterPage.routeName:
        double args = settings.arguments as double;
        return MaterialPageRoute(
          builder: (_) => FilterPage(
            maxPrice: args,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
      ),
      settings: RouteSettings(name: '/error'),
    );
  }
}
