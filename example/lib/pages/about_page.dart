import 'package:flutter/material.dart';

/// The about page widget that displays information about the go_router_sugar package.
class AboutPage extends StatelessWidget {
  /// Creates an about page widget.
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Go Router Sugar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Go Router Sugar is a zero-effort, file-based routing system '
              'for Flutter applications. It automatically generates GoRouter '
              'configuration based on your file structure.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Automatic route generation'),
            Text('• Type-safe navigation'),
            Text('• Dynamic route parameters'),
            Text('• Hot reload support'),
            Text('• Highly configurable'),
          ],
        ),
      ),
    );
  }
}
