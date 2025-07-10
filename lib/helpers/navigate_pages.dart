import 'package:flutter/material.dart';

import 'package:kaagappay/views/auth/login_page.dart';
import 'package:kaagappay/views/auth/signup_page.dart';
import 'package:kaagappay/views/home/market_trend_page.dart';
import 'package:kaagappay/views/home/farmer_details_page.dart';
import 'package:kaagappay/views/home/marketplace_page.dart';
import 'package:kaagappay/views/home/news_page.dart';
import 'package:kaagappay/views/home/sell_product_page.dart';
import 'package:kaagappay/views/notifications/system_notification_page.dart';
import 'package:kaagappay/views/notifications/trends_notification_page.dart';
import 'package:kaagappay/views/profile/edit_profile_page.dart';
import 'package:kaagappay/views/profile/profile_page.dart';
import 'package:kaagappay/views/settings/about_us_page.dart';
import 'package:kaagappay/views/settings/contact_page.dart';
import 'package:kaagappay/views/settings/feedback_page.dart';
import 'package:kaagappay/views/settings/help_center_page.dart';
import 'package:kaagappay/views/settings/privacy_policy_page.dart';
import 'package:kaagappay/views/settings/settings_page.dart';
import 'package:kaagappay/views/splash_screen.dart';

class NavigatePages {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String marketTrend = '/market_trend';
  static const String farmerDetails = '/farmer_details';
  static const String marketplace = '/marketplace';
  static const String news = '/news';
  static const String sellProduct = '/sell_product';
  static const String trendsNotification = '/trends_notification';
  static const String systemNotification = '/system_notification';
  static const String profile = '/profile';
  static const String editProfile = '/edit_profile';
  static const String aboutUs = '/about_us';
  static const String contact = '/contact';
  static const String feedback = '/feedback';
  static const String helpCenter = '/help_center';
  static const String privacyPolicy = '/privacy_policy';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigatePages.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case NavigatePages.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case NavigatePages.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case NavigatePages.marketTrend:
        return MaterialPageRoute(builder: (_) => const MarketTrendPage());
      case NavigatePages.farmerDetails:
        return MaterialPageRoute(builder: (_) => const FarmerDetailsPage());
      case NavigatePages.marketplace:
        return MaterialPageRoute(builder: (_) => const MarketplacePage());
      case NavigatePages.news:
        return MaterialPageRoute(builder: (_) => const NewsPage());
      case NavigatePages.sellProduct:
        return MaterialPageRoute(builder: (_) => const SellProductPage());
      case NavigatePages.trendsNotification:
        return MaterialPageRoute(builder: (_) => const TrendsNotificationPage());
      case NavigatePages.systemNotification:
        return MaterialPageRoute(builder: (_) => const SystemNotificationPage());
      case NavigatePages.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case NavigatePages.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case NavigatePages.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case NavigatePages.contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      case NavigatePages.feedback:
        return MaterialPageRoute(builder: (_) => const FeedbackPage());
      case NavigatePages.helpCenter:
        return MaterialPageRoute(builder: (_) => const HelpCenterPage());
      case NavigatePages.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case NavigatePages.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
