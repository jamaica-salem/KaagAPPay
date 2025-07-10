import 'package:flutter/material.dart';

class TrendsNotificationPage extends StatelessWidget {
  const TrendsNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to the Trends Notification !',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
