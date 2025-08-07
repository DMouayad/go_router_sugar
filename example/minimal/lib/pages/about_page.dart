import 'package:flutter/material.dart';

/// Simple about page showing how easy nested routes are
class AboutPage extends StatelessWidget {
  /// Creates an about page widget.
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Created by simply adding about_page.dart',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'File-based routing = Zero configuration! ✨',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
