import 'package:flutter/material.dart';
import 'app_router.g.dart';

/// The main entry point of the go_router_sugar example application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the example application demonstrating go_router_sugar.
class MyApp extends StatelessWidget {
  /// Creates the main app widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Sugar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
