/// # go_router_sugar
///
/// **Zero-effort file-based routing for Flutter with go_router.**
///
/// This library provides automatic route generation based on your file structure,
/// eliminating the need to manually configure GoRouter routes.
///
/// ## Key Features
///
/// - 🚀 **Zero Boilerplate**: No manual GoRoute configuration needed
/// - 📁 **File-Based Routing**: Your file system becomes your route map
/// - 🔧 **Highly Configurable**: Customize directory, naming conventions, and more
/// - 🛡️ **Type-Safe Navigation**: Auto-generated navigation helpers prevent runtime errors
/// - ⚡ **Dynamic Routes**: Built-in support for path parameters using square bracket syntax (e.g., `[id]`)
/// - 🎯 **Flutter-First**: Designed specifically for Flutter's ecosystem
///
/// ## Usage
///
/// 1. Create your page files in `lib/pages/` (or your configured directory).
/// 2. Run the code generator: `dart run build_runner build`
/// 3. Use the generated router and navigation helpers in your app.
///
/// See the README for full documentation and examples.
library go_router_sugar;

// Export the main classes and utilities that users will interact with
export 'src/route_info.dart' show RouteInfo, RouteParameter;
export 'src/extensions.dart' show GoRouterSugarExtensions;
export 'src/transitions.dart'
    show PageTransitionType, TransitionConfig, PageTransition;
export 'src/guards.dart'
    show
        RouteGuard,
        AuthGuard,
        RouteGuards,
        RouteMiddlewares,
        logPageView,
        trackAnalytics;

// 🧪 EXPERIMENTAL: These features are in active development
export 'src/query_params.dart'
    show QueryParams, QueryParameterType, QueryParamNavigation;
export 'src/analytics.dart'
    show
        RouteAnalytics,
        RoutePerformance,
        NavigationEvent,
        AnalyticsProvider,
        ConsoleAnalyticsProvider;

// Re-export commonly used go_router classes for convenience
export 'package:go_router/go_router.dart' show GoRouter, GoRoute, GoRouterState;

/// The current version of the go_router_sugar package.
const String packageVersion = '1.0.0';

/// Default configuration constants for go_router_sugar.
///
/// These can be referenced by users and by the code generator.
/// Configuration constants for go_router_sugar code generation and usage.
///
/// These values are used as defaults by the code generator and can be referenced
/// by users for consistency in custom setups.
class GoRouterSugarConfig {
  /// Default directory where page files are located.
  static const String defaultPagesDirectory = 'lib/pages';

  /// Default suffix for page files (e.g., 'home_page.dart').
  static const String defaultPageSuffix = '_page';

  /// Default name for the generated router class.
  static const String defaultRouterClassName = 'AppRouter';

  /// Default output file name for generated code.
  static const String defaultOutputFile = 'lib/app_router.g.dart';

  /// The character that marks the start of a dynamic parameter in a file name.
  /// For example, `[id]_page.dart` will generate a route with a dynamic `:id` parameter.
  static const String parameterStartDelimiter = '[';

  /// The character that marks the end of a dynamic parameter in a file name.
  static const String parameterEndDelimiter = ']';

  /// Whether to generate navigation helpers by default.
  static const bool defaultGenerateNavigationHelpers = true;

  /// Whether to generate route constants by default.
  static const bool defaultGenerateRouteConstants = true;
}
