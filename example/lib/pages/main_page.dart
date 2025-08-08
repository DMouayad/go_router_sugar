import 'package:flutter/material.dart';

/// Main page demonstrating basic routing setup.
class MainPage extends StatelessWidget {
  /// Creates a main page.
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: const Center(
        child: Text('This is the MainPage.'),
      ),
    );
  }
}
