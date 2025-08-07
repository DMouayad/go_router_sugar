import 'package:flutter/material.dart';
import '../app_router.g.dart';

/// The home page widget that serves as the main entry point.
class HomePage extends StatelessWidget {
  /// Creates a home page widget.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Router Sugar Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Go Router Sugar!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This app demonstrates file-based routing.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Navigation examples using generated helpers
            ElevatedButton(
              onPressed: () => Navigate.goToAbout(),
              child: const Text('Go to About'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigate.goToProductslist(),
              child: const Text('View Products'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigate.pushToProductsid(id: 'demo-product'),
              child: const Text('View Demo Product'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigate.goToUserprofilesettings(),
              child: const Text('Profile Settings'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigate.goToAnimated(),
              child: const Text('Animated Page (Fade Transition)'),
            ),
          ],
        ),
      ),
    );
  }
}
