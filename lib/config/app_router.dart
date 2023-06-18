import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/widgets/auth/reset_password.dart';
import 'package:projeto_computacao_movel/widgets/filter_page.dart';
import 'package:projeto_computacao_movel/widgets/financer/profile.dart';
import 'package:projeto_computacao_movel/widgets/financer/proposal_page.dart';
import 'package:projeto_computacao_movel/widgets/home_page.dart';
import 'package:projeto_computacao_movel/widgets/auth/login_page.dart';
import 'package:projeto_computacao_movel/widgets/auth/register_page.dart';
import 'package:projeto_computacao_movel/widgets/auth/email_verification.dart';
import 'package:projeto_computacao_movel/widgets/financer/shop_page.dart';
import 'package:projeto_computacao_movel/widgets/auth/verify_code.dart';
import 'package:projeto_computacao_movel/widgets/project_details.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        HomePageArguments? args = settings.arguments as HomePageArguments?;
        return MaterialPageRoute(
          builder: (_) => HomePage(
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
      case ProjectDetails.routeName:
        Project args = settings.arguments as Project;
        return MaterialPageRoute(
          builder: (_) => ProjectDetails(
            project: args,
          ),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
        );
      case EmailVerification.routeName:
        return MaterialPageRoute(
          builder: (_) => EmailVerification(),
        );
      case VerifyCode.routeName:
        return MaterialPageRoute(
          builder: (_) => VerifyCode(),
        );
      case ResetPassword.routeName:
        return MaterialPageRoute(
          builder: (_) => ResetPassword(),
        );
      case Profile.routeName:
        return MaterialPageRoute(
          builder: (_) => Profile(),
        );
      case ProposalPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ProposalPage(),
        );
      case ShopPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ShopPage(),
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
