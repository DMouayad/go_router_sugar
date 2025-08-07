import 'package:meta/meta.dart';

/// Base class for route guards.
///
/// Route guards allow you to control access to routes based on
/// authentication, permissions, or other business logic.
abstract class RouteGuard {
  /// Creates a route guard.
  const RouteGuard();

  /// Determines if the route can be activated.
  ///
  /// Returns `true` if the route can be accessed, `false` otherwise.
  /// If `false` is returned, the user will be redirected to [redirectTo].
  Future<bool> canActivate(String route, Map<String, String> params);

  /// The route to redirect to if [canActivate] returns `false`.
  String get redirectTo;
}

/// Route guard that requires user authentication.
class AuthGuard extends RouteGuard {
  /// Creates an authentication guard.
  const AuthGuard({this.redirectTo = '/login'});

  @override
  final String redirectTo;

  @override
  Future<bool> canActivate(String route, Map<String, String> params) async {
    // Replace with your actual authentication logic
    return _isUserLoggedIn();
  }

  bool _isUserLoggedIn() {
    // Implement your authentication check here
    return false; // Placeholder
  }
}

/// Route guard annotation to protect pages.
///
/// Use this annotation on your page classes to require authentication
/// or other permissions.
///
/// Example:
/// ```dart
/// @RouteGuards([AuthGuard()])
/// class ProfilePage extends StatelessWidget {
///   // ...
/// }
/// ```
@immutable
class RouteGuards {
  /// Creates route guards annotation.
  const RouteGuards(this.guards);

  /// The list of guards that must pass for this route.
  final List<RouteGuard> guards;
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
