import 'package:flutter/material.dart';

/// MarketTrendPage serves as the home screen after the splash screen.
/// This is where you can later display market trends, graphs, or user data.
class MarketTrendPage extends StatelessWidget {
  const MarketTrendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Trends'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to KaagAPPay!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
