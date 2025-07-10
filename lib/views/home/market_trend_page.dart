import 'package:flutter/material.dart';
import 'package:kaagappay/components/bottom_nav_bar.dart';  // <-- Make sure this import is correct

class MarketTrendPage extends StatefulWidget {
  const MarketTrendPage({Key? key}) : super(key: key);

  @override
  State<MarketTrendPage> createState() => _MarketTrendPageState();
}

class _MarketTrendPageState extends State<MarketTrendPage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Optional: Add navigation here if needed
    // Example:
    // if (index == 1) Navigator.pushNamed(context, NavigatePages.marketplace);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to the Market Trend Page!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
