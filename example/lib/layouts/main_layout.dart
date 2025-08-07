import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main application layout with navigation
///
/// This layout will be automatically detected and used as a shell route
/// for all pages in the /dashboard directory.
class MainLayout extends StatelessWidget {
  /// Creates the main layout.
  const MainLayout({
    super.key,
    required this.child,
  });

  /// The child widget to display in the main content area.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Router Sugar Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => context.go('/home'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => context.go('/about'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Products'),
              onTap: () => context.go('/products/list'),
            ),
            ListTile(
              leading: const Icon(Icons.animation),
              title: const Text('Animated Page'),
              onTap: () => context.go('/animated'),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
