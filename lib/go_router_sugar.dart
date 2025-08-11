/// # go_router_sugar
///
/// **Zero-effort file-based routing for Flutter with go_router.**
///
/// Transform your Flutter routing from complex configuration to intuitive file organization.
/// Your file system IS your route map - no boilerplate, no configuration, just works.
///
/// ## Core Philosophy: Zero Ambiguity
///
/// - 🎯 **Constructor Parameters = Route Parameters**: No manual parameter extraction
/// - 📁 **File-Based Routing**: Your file system becomes your route map
/// - � **Smart Defaults**: Works out of the box with intelligent conventions
/// - 🛡️ **Type-Safe Navigation**: Impossible to make navigation errors
/// - ⚡ **One-Command Setup**: `dart run go_router_sugar new my_app`
/// - 🔧 **Progressive Enhancement**: Simple start, powerful when needed
///
/// ## Quick Start
///
/// ```bash
/// # Create complete app with routing ready
/// dart run go_router_sugar new my_app --template minimal
/// cd my_app && flutter run
/// ```
///
/// ```dart
/// // Constructor parameters become route parameters automatically
/// class ProductPage extends StatelessWidget {
///   final String productId;    // ✅ Auto-injected from /products/:productId
///   final String? category;    // ✅ Auto-injected from ?category=electronics
///
///   const ProductPage({required this.productId, this.category});
/// }
///
/// // Type-safe navigation with perfect IntelliSense
/// Navigate.goToProduct(productId: '123', category: 'electronics');
/// ```
library;

// Export the main classes and utilities that users will interact with
export 'src/route_info.dart' show RouteInfo;
export 'src/extensions.dart' show GoRouterSugarExtensions;
export 'src/transitions.dart'
    show PageTransitionType, TransitionConfig, PageTransition;

// Re-export GoRouter classes so generated code can use them without separate dependency
export 'package:go_router/go_router.dart';

// 🎯 Zero-Ambiguity Features: Smart Guards & Parameter Detection
export 'src/smart_guards.dart'
    show
        RouteGuard,
        AuthGuard,
        RoleGuard,
        Protected,
        RouteGuards,
        RouteMiddlewares,
        logPageView,
        trackAnalytics;
export 'src/parameter_detector.dart'
    show ParameterDetector, ParameterAnalysis, RouteParameter, QueryParameter;
export 'src/core/templates.dart' show AppTemplate, PageTemplate;

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

// CLI tools (primarily for internal use by executables)
export 'interactive_cli.dart' show InteractiveCLI;

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
