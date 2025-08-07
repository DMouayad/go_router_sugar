import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

/// Extension methods to enhance GoRouter functionality
extension GoRouterSugarExtensions on GoRouter {
  /// Navigate to a route with parameters in a more convenient way
  void navigateTo(String route,
      {Map<String, String>? pathParams, Object? extra}) {
    if (pathParams != null && pathParams.isNotEmpty) {
      // Replace path parameters in the route
      String finalRoute = route;
      pathParams.forEach((key, value) {
        finalRoute = finalRoute.replaceAll(':$key', value);
      });
      go(finalRoute, extra: extra);
    } else {
      go(route, extra: extra);
    }
  }

  /// Push a route with parameters
  void pushTo(String route, {Map<String, String>? pathParams, Object? extra}) {
    if (pathParams != null && pathParams.isNotEmpty) {
      String finalRoute = route;
      pathParams.forEach((key, value) {
        finalRoute = finalRoute.replaceAll(':$key', value);
      });
      push(finalRoute, extra: extra);
    } else {
      push(route, extra: extra);
    }
  }
}

/// Extension methods for BuildContext to make navigation easier
extension GoRouterSugarContext on BuildContext {
  /// Get the current GoRouter instance
  GoRouter get router => GoRouter.of(this);

  /// Navigate to a route using the current context
  void navigateTo(String route,
      {Map<String, String>? pathParams, Object? extra}) {
    router.navigateTo(route, pathParams: pathParams, extra: extra);
  }

  /// Push a route using the current context
  void pushTo(String route, {Map<String, String>? pathParams, Object? extra}) {
    router.pushTo(route, pathParams: pathParams, extra: extra);
  }

  /// Pop the current route
  void popRoute() {
    if (router.canPop()) {
      router.pop();
    }
  }
}
