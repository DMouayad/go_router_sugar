import 'package:meta/meta.dart';
import 'transitions.dart';

/// Represents information about a route discovered during code generation.
///
/// This class encapsulates all the data needed to generate a GoRoute
/// including the file path, route path, parameters, and class information.
@immutable
class RouteInfo {
  /// Creates a new RouteInfo instance
  const RouteInfo({
    required this.filePath,
    required this.routePath,
    required this.className,
    required this.parameters,
    required this.importPath,
    this.transitionConfig,
  });

  /// Creates a RouteInfo from a file path and pages directory
  factory RouteInfo.fromPath(String filePath, String pagesDirectory) {
    // Remove the pages directory prefix and file extension
    final relativePath =
        filePath.replaceFirst('$pagesDirectory/', '').replaceAll('.dart', '');

    // Extract the class name from the full path
    final className = _pathToClassName(relativePath);

    // Convert file path to route path and extract parameters
    final routeData = _pathToRoute(relativePath);

    return RouteInfo(
      filePath: filePath,
      routePath: routeData.path,
      className: className,
      parameters: routeData.parameters,
      importPath: filePath.replaceFirst('lib/', ''),
      transitionConfig: null, // Will be detected from annotations at build time
    );
  }

  /// The original file path relative to the project root
  final String filePath;

  /// The generated route path (e.g., '/products/:id')
  final String routePath;

  /// The class name of the page widget
  final String className;

  /// List of dynamic parameters extracted from the route
  final List<RouteParameter> parameters;

  /// The import path for the page file
  final String importPath;

  /// Optional transition configuration for this route
  final TransitionConfig? transitionConfig;

  /// Whether this route has any dynamic parameters
  bool get hasDynamicParams => parameters.isNotEmpty;

  /// Converts a file path to a Pascal case class name
  /// Example: 'user/profile/settings_page' -> 'UserProfileSettingsPage'
  /// Example: 'products/\[id\]_page' -> 'ProductsIdPage'
  static String _pathToClassName(String path) {
    final segments = path
        .replaceAll('_page', '') // Remove page suffix
        .replaceAll('[', '') // Remove dynamic param brackets
        .replaceAll(']', '')
        .split('/')
        .map((segment) => segment
            .split('_')
            .map((part) => part.isNotEmpty
                ? '${part[0].toUpperCase()}${part.substring(1)}'
                : '')
            .join(''))
        .join('');
    return '${segments}Page';
  }

  /// Converts a file path to a route path with parameters
  /// Example: 'products/\[id\]_page' -> path: '/products/:id', params: ['id']
  static _RouteData _pathToRoute(String path) {
    final segments = path.split('/');
    final parameters = <RouteParameter>[];

    final routeSegments = segments.map((segment) {
      // Handle dynamic parameters like [id]_page
      if (segment.contains('[') && segment.contains(']')) {
        final paramStart = segment.indexOf('[');
        final paramEnd = segment.indexOf(']');
        final paramName = segment.substring(paramStart + 1, paramEnd);

        parameters.add(RouteParameter(
          name: paramName,
          isRequired: true, // All path parameters are required by default
        ));

        return ':$paramName';
      }

      // Remove _page suffix from regular segments
      return segment.replaceAll('_page', '');
    }).toList();

    final routePath = '/${routeSegments.join('/')}';

    return _RouteData(path: routePath, parameters: parameters);
  }

  @override
  String toString() => 'RouteInfo(path: $routePath, class: $className)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteInfo &&
          runtimeType == other.runtimeType &&
          filePath == other.filePath &&
          routePath == other.routePath &&
          className == other.className;

  @override
  int get hashCode => Object.hash(filePath, routePath, className);
}

/// Represents a dynamic parameter in a route
@immutable
class RouteParameter {
  /// Creates a route parameter.
  const RouteParameter({
    required this.name,
    this.isRequired = true,
    this.description,
  });

  /// The parameter name (e.g., 'id' for ':id')
  final String name;

  /// Whether this parameter is required
  final bool isRequired;

  /// Optional description of the parameter
  final String? description;

  @override
  String toString() => 'RouteParameter($name, required: $isRequired)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteParameter &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          isRequired == other.isRequired;

  @override
  int get hashCode => Object.hash(name, isRequired);
}

/// Internal class to hold route path and parameters during parsing
class _RouteData {
  _RouteData({required this.path, required this.parameters});

  final String path;
  final List<RouteParameter> parameters;
}
