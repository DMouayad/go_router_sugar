import 'package:flutter/material.dart';

/// Welcome screen demonstrating custom directory usage
class WelcomePage extends StatelessWidget {
  /// Creates a welcome page widget.
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This page is in lib/screens/ instead of lib/pages/',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Generated using --pages-dir lib/screens 🎉',
              style: TextStyle(fontSize: 16, color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
