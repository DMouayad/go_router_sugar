import 'package:flutter/material.dart';

/// Zero-config route guard system
///
/// Just implement the interface and use with `@Protected(YourGuard)`
abstract class RouteGuard {
  /// Return true to allow navigation, false to block
  Future<bool> canActivate(BuildContext context, Map<String, String> params);

  /// Optional: Handle redirect when guard fails
  String? get redirectRoute => null;
}

/// Simple auth guard implementation
class AuthGuard implements RouteGuard {
  @override
  Future<bool> canActivate(
      BuildContext context, Map<String, String> params) async {
    // Override this in your app with your auth logic
    return true; // Default: allow all (override in your implementation)
  }

  @override
  String? get redirectRoute => '/login';
}

/// Role-based permission guard
class RoleGuard implements RouteGuard {
  final List<String> requiredRoles;

  const RoleGuard(this.requiredRoles);

  @override
  Future<bool> canActivate(
      BuildContext context, Map<String, String> params) async {
    // Override this in your app with your permission logic
    return true; // Default: allow all (override in your implementation)
  }

  @override
  String? get redirectRoute => '/unauthorized';
}

/// Annotation for protecting routes with guards
class Protected {
  final Type guardType;

  const Protected(this.guardType);
}

/// Multiple guards annotation
class RouteGuards {
  final List<Type> guards;

  const RouteGuards(this.guards);
}

/// Middleware function type for route processing.
typedef RouteMiddleware = Future<void> Function(
    String route, Map<String, String> params);

/// Route middleware annotation for pages.
///
/// Use this to add logging, analytics, or other cross-cutting concerns.
///
/// Example:
/// ```dart
/// @RouteMiddlewares([logPageView, trackAnalytics])
/// class HomePage extends StatelessWidget {
///   // ...
/// }
/// ```
@immutable
class RouteMiddlewares {
  /// Creates route middlewares annotation.
  const RouteMiddlewares(this.middlewares);

  /// The list of middleware functions to execute.
  final List<RouteMiddleware> middlewares;
}

/// Example middleware function for logging page views.
Future<void> logPageView(String route, Map<String, String> params) async {
  print('Page view: $route with params: $params');
}

/// Example middleware function for analytics tracking.
Future<void> trackAnalytics(String route, Map<String, String> params) async {
  // Implement your analytics tracking here
  print('Analytics: User navigated to $route');
}
