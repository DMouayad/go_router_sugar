import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile'),
      ),
      body: const Center(
        child: Text(
          'profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
