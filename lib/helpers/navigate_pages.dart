import 'package:flutter/material.dart';
import 'package:kaagappay/views/auth/login_page.dart';
import 'package:kaagappay/views/auth/signup_page.dart';
import 'package:kaagappay/views/home/market_trend_page.dart';
import 'package:kaagappay/views/splash_screen.dart';

class NavigatePages {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String marketTrend = '/market_trend';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case marketTrend:
        return MaterialPageRoute(builder: (_) => const MarketTrendPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
