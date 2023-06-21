import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/arguments/filter_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/project_arguments.dart';
import 'package:projeto_computacao_movel/modules/arguments/user_arguments.dart';
import 'package:projeto_computacao_movel/widgets/admin/admin_shop_page.dart';
import 'package:projeto_computacao_movel/widgets/admin/financers_page.dart';
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
            token: args?.token,
          ),
        );
      case FilterPage.routeName:
        FilterPageArguments? args = settings.arguments as FilterPageArguments?;
        return MaterialPageRoute(
          builder: (_) => FilterPage(
            maxPrice: args?.maxPrice ?? 0,
            token: args?.token,
          ),
        );
      case ProjectDetails.routeName:
        ProjectArguments args = settings.arguments as ProjectArguments;
        return MaterialPageRoute(
          builder: (_) => ProjectDetails(
            project: args.project,
            token: args.token,
            user: args.user,
          ),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      case EmailVerification.routeName:
        return MaterialPageRoute(
          builder: (_) => const EmailVerification(),
        );
      case VerifyCode.routeName:
        return MaterialPageRoute(
          builder: (_) => const VerifyCode(),
        );
      case ResetPassword.routeName:
        return MaterialPageRoute(
          builder: (_) => const ResetPassword(),
        );
      case Profile.routeName:
        UserArguments? args = settings.arguments as UserArguments?;
        return MaterialPageRoute(
          builder: (_) => Profile(
            token: args?.token,
          ),
        );
      case ProposalPage.routeName:
        String? args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ProposalPage(
            token: args,
          ),
        );
      case ShopPage.routeName:
        String? args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ShopPage(
            token: args,
          ),
        );
      case FinancersAdminPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const FinancersAdminPage(),
        );
      case ShopPageAdmin.routeName:
        String? args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ShopPageAdmin(
            token: args,
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
          title: const Text('error'),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
