import 'package:flutter/material.dart';

/// Simple home page demonstrating basic file-based routing
class HomePage extends StatelessWidget {
  /// Creates a home page widget.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal Example'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Go Router Sugar!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This page was created just by adding home_page.dart',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'No manual route configuration needed! 🎉',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
