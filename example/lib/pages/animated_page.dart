import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

/// Example page demonstrating transition configuration
///
/// This page uses the @PageTransition annotation to specify a fade transition.
@PageTransition(TransitionConfig.fade)
class AnimatedPage extends StatelessWidget {
  /// Creates an animated page.
  const AnimatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Page'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.animation,
              size: 100,
              color: Colors.purple,
            ),
            SizedBox(height: 20),
            Text(
              'This page uses a fade transition!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'The transition was configured using the @PageTransition annotation.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
