import 'package:flutter/material.dart';
import 'app_router.g.dart';

/// Minimal example demonstrating go_router_sugar's file-based routing
void main() {
  runApp(const MinimalApp());
}

/// The main app widget for the minimal example.
class MinimalApp extends StatelessWidget {
  /// Creates the minimal app widget.
  const MinimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Minimal Go Router Sugar',
      routerConfig: AppRouter.router,
    );
  }
}
