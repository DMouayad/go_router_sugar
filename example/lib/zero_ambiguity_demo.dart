import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

// 🎯 Zero-Ambiguity Demo: How the new features eliminate all configuration

// ✅ 1. Smart Parameter Detection - Constructor parameters = Route parameters
class ProductPage extends StatelessWidget {
  // Required parameters become route parameters (/products/:productId)
  final String productId;

  // Optional parameters become query parameters (?category=electronics&page=2)
  final String? category;
  final int? page;
  final bool? featured;

  const ProductPage({
    super.key,
    required this.productId, // Route parameter (required)
    this.category, // Query parameter (optional String)
    this.page, // Query parameter (optional int)
    this.featured, // Query parameter (optional bool)
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $productId')),
      body: Column(
        children: [
          Text('Product ID: $productId'),
          if (category != null) Text('Category: $category'),
          if (page != null) Text('Page: $page'),
          if (featured == true) const Text('⭐ Featured Product'),
        ],
      ),
    );
  }
}

// ✅ 2. Zero-Config Route Guards - Just implement interface
class AuthGuard implements RouteGuard {
  @override
  Future<bool> canActivate(
      BuildContext context, Map<String, String> params) async {
    // Your auth logic here (replace with real implementation)
    final isLoggedIn = await _checkAuthStatus();
    return isLoggedIn;
  }

  @override
  String? get redirectRoute => '/login';

  Future<bool> _checkAuthStatus() async {
    // Simulate auth check
    return true; // Replace with your actual auth logic
  }
}

// ✅ 3. Protected Routes - One annotation protects the entire page
@Protected(AuthGuard)
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(
        child: Text('Protected Dashboard - Only accessible when logged in'),
      ),
    );
  }
}

// ✅ 4. Multiple Guards - Combine authentication and permissions
class AdminGuard implements RouteGuard {
  @override
  Future<bool> canActivate(
      BuildContext context, Map<String, String> params) async {
    final hasAdminRole = await _checkAdminRole();
    return hasAdminRole;
  }

  @override
  String? get redirectRoute => '/unauthorized';

  Future<bool> _checkAdminRole() async {
    // Your role check logic here
    return true; // Replace with actual role check
  }
}

@RouteGuards([AuthGuard, AdminGuard])
class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: const Center(
        child: Text('Admin Only - Requires authentication AND admin role'),
      ),
    );
  }
}

// ✅ 5. Smart Transitions - One annotation for beautiful animations
@PageTransition(TransitionConfig.slideUp)
class ModalPage extends StatelessWidget {
  const ModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modal')),
      body: const Center(
        child: Text('This page slides up like a modal'),
      ),
    );
  }
}

// ✅ 6. Custom Transitions - Full control when needed
@PageTransition(TransitionConfig(
  type: PageTransitionType.rotation,
  durationMs: 600,
  curveType: 'bounceOut',
))
class CreativePage extends StatelessWidget {
  const CreativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Creative Transition')),
      body: const Center(
        child: Text('This page rotates in with elastic animation'),
      ),
    );
  }
}

// ✅ Generated Navigation Usage (this is what gets auto-generated):
class NavigationDemo extends StatelessWidget {
  const NavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Demo')),
      body: Column(
        children: [
          // Type-safe navigation with perfect IntelliSense
          ElevatedButton(
            onPressed: () => Navigate.goToProduct(
              productId: '123', // ✅ Required parameter
              category: 'electronics', // ✅ Optional parameter
              page: 2, // ✅ Type-safe int
              featured: true, // ✅ Type-safe bool
            ),
            child: const Text('Go to Product'),
          ),

          ElevatedButton(
            onPressed: () => Navigate.goToDashboard(), // ✅ Protected route
            child: const Text('Go to Dashboard'),
          ),

          ElevatedButton(
            onPressed: () => Navigate.goToAdminPanel(), // ✅ Multi-guard route
            child: const Text('Go to Admin Panel'),
          ),

          ElevatedButton(
            onPressed: () => Navigate.goToModal(), // ✅ Animated transition
            child: const Text('Show Modal'),
          ),
        ],
      ),
    );
  }
}

// 🎯 The Result: Zero Configuration, Maximum Power
//
// What you DON'T have to do anymore:
// ❌ Manual GoRoute configuration
// ❌ Manual parameter extraction from GoRouterState
// ❌ String-based navigation (typo-prone)
// ❌ Complex guard registration
// ❌ Boilerplate transition setup
// ❌ Manual route constant definitions
//
// What you GET automatically:
// ✅ Type-safe navigation with IntelliSense
// ✅ Automatic parameter injection
// ✅ Zero-config route protection
// ✅ Beautiful transitions with one annotation
// ✅ Impossible to make navigation typos
// ✅ Perfect IDE support and autocomplete

// Example of the generated Navigate class (for illustration):
abstract class Navigate {
  // Generated navigation methods with perfect type safety
  static void goToProduct({
    required String productId,
    String? category,
    int? page,
    bool? featured,
  }) {
    // Auto-generated implementation handles all the complexity
  }

  static void goToDashboard() {
    // Auto-generated with guard checks
  }

  static void goToAdminPanel() {
    // Auto-generated with multi-guard checks
  }

  static void goToModal() {
    // Auto-generated with slide-up transition
  }
}
