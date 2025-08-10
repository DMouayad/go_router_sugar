import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Home page - The starting point of the app
class HomePage extends StatelessWidget {
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
              '🍬 Go Router Sugar Demo',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'The Simplest Flutter Routing Ever!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/products/list'),
              child: const Text('View Products'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/products/123'),
              child: const Text('View Product #123'),
            ),
          ],
        ),
      ),
    );
  }
}
