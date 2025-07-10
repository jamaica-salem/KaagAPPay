import 'package:flutter/material.dart';
import 'helpers/navigate_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KaagAPPay',
      theme: ThemeData(fontFamily: 'Sora'),
      initialRoute: NavigatePages.splash,
      onGenerateRoute: NavigatePages.generateRoute,
    );
  }
}
