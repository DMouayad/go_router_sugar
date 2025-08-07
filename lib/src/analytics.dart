import 'package:meta/meta.dart';

/// Route analytics configuration.
///
/// Automatically tracks route usage, performance, and user behavior.
@immutable
class RouteAnalytics {
  /// Creates route analytics configuration.
  const RouteAnalytics({
    this.enabled = true,
    this.trackPageViews = true,
    this.trackNavigationTime = true,
    this.trackUserJourney = true,
    this.customProperties = const {},
  });

  /// Whether analytics tracking is enabled.
  final bool enabled;

  /// Whether to track page view events.
  final bool trackPageViews;

  /// Whether to track navigation timing.
  final bool trackNavigationTime;

  /// Whether to track user journey flow.
  final bool trackUserJourney;

  /// Custom properties to include with all events.
  final Map<String, dynamic> customProperties;
}

/// Performance monitoring for route transitions.
@immutable
class RoutePerformance {
  /// Creates route performance configuration.
  const RoutePerformance({
    this.enabled = true,
    this.trackTransitionDuration = true,
    this.trackBuildTime = true,
    this.slowTransitionThreshold = const Duration(milliseconds: 300),
  });

  /// Whether performance monitoring is enabled.
  final bool enabled;

  /// Whether to track transition animation duration.
  final bool trackTransitionDuration;

  /// Whether to track widget build time.
  final bool trackBuildTime;

  /// Threshold for flagging slow transitions.
  final Duration slowTransitionThreshold;
}

/// Navigation event data.
@immutable
class NavigationEvent {
  /// Creates navigation event.
  const NavigationEvent({
    required this.fromRoute,
    required this.toRoute,
    required this.timestamp,
    required this.duration,
    this.parameters = const {},
    this.transitionType,
  });

  /// The route being navigated from.
  final String fromRoute;

  /// The route being navigated to.
  final String toRoute;

  /// When the navigation occurred.
  final DateTime timestamp;

  /// How long the navigation took.
  final Duration duration;

  /// Route parameters.
  final Map<String, String> parameters;

  /// Type of transition used.
  final String? transitionType;
}

/// Analytics provider interface.
abstract class AnalyticsProvider {
  /// Track a navigation event.
  Future<void> trackNavigation(NavigationEvent event);

  /// Track a custom event.
  Future<void> trackEvent(String eventName, Map<String, dynamic> properties);

  /// Track performance metrics.
  Future<void> trackPerformance(String metricName, Duration duration);
}

/// Built-in console analytics provider for debugging.
class ConsoleAnalyticsProvider implements AnalyticsProvider {
  /// Creates console analytics provider.
  const ConsoleAnalyticsProvider();

  @override
  Future<void> trackNavigation(NavigationEvent event) async {
    print(
        '🚀 Navigation: ${event.fromRoute} → ${event.toRoute} (${event.duration.inMilliseconds}ms)');
  }

  @override
  Future<void> trackEvent(
      String eventName, Map<String, dynamic> properties) async {
    print('📊 Event: $eventName with $properties');
  }

  @override
  Future<void> trackPerformance(String metricName, Duration duration) async {
    print('⚡ Performance: $metricName took ${duration.inMilliseconds}ms');
  }
}

/// Route analytics annotation.
///
/// Use this to enable detailed analytics for specific routes.
///
/// Example:
/// ```dart
/// @RouteAnalytics(
///   trackPageViews: true,
///   customProperties: {'category': 'ecommerce'},
/// )
/// class ProductPage extends StatelessWidget {
///   // ...
/// }
/// ```
@immutable
class RouteAnalyticsConfig {
  /// Creates route analytics annotation.
  const RouteAnalyticsConfig(this.config);

  /// The analytics configuration.
  final RouteAnalytics config;
}
