import 'package:flutter/material.dart';

class SystemNotificationPage extends StatelessWidget {
  const SystemNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to the System Notification !',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
