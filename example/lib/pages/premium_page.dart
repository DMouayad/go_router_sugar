import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

/// Advanced example page demonstrating route guards and analytics.
///
/// This page requires authentication and tracks detailed analytics.
@Protected(AuthGuard)
@PageTransition(TransitionConfig(
  type: PageTransitionType.parallax,
  durationMs: 400,
  curveType: 'easeInOutCubic',
))
class PremiumPage extends StatelessWidget {
  /// Creates a premium page.
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.diamond,
              size: 64,
              color: Colors.purple,
            ),
            SizedBox(height: 24),
            Text(
              'Premium Features',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This page demonstrates advanced go_router_sugar features:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text('🔐 Route Guards - Authentication required'),
            Text('📊 Analytics - Automatic tracking enabled'),
            Text('🎨 Parallax Transition - Advanced animation'),
            Text('⚡ Type-Safe Navigation - Zero runtime errors'),
            Text('🎯 Query Parameters - Strongly typed'),
            SizedBox(height: 24),
            Text(
              'Features Coming Soon:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('🛠️ CLI Tool for scaffolding'),
            Text('🔌 VS Code Extension'),
            Text('🗂️ Shell Routes with layouts'),
            Text('📈 Performance monitoring'),
            Text('🎭 Custom transition builder'),
          ],
        ),
      ),
    );
  }
}
