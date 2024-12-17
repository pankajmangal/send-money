import 'package:flutter/material.dart';
import 'package:send_money/presentation/screens/home_screen.dart';
import 'package:send_money/presentation/screens/login_screen.dart';
import 'package:send_money/presentation/screens/send_money_screen.dart';
import 'package:send_money/presentation/screens/splash_screen.dart';
import 'package:send_money/presentation/screens/transaction_history_screen.dart';
import 'package:send_money/routes/RoutesPath.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPath.SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutesPath.AUTH_LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutesPath.HOME:
        // var value = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutesPath.SEND_MONEY:
        return MaterialPageRoute(builder: (_) => SendMoneyScreen());
      case RoutesPath.TRANSACTION_HISTORY:
        return MaterialPageRoute(builder: (_) => TransactionHistoryScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}