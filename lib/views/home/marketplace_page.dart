import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to the Marketplace Page!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
