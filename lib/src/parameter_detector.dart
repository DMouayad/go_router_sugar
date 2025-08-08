// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/element/element.dart';

/// Smart parameter detection for automatic route parameter injection
class ParameterDetector {
  /// Analyzes a widget's constructor and determines route/query parameters
  static ParameterAnalysis analyzeConstructor(ClassElement classElement) {
    final constructors = classElement.constructors;
    if (constructors.isEmpty) {
      return ParameterAnalysis.empty();
    }

    // Find the main constructor (preferably const constructor)
    final constructor = constructors.firstWhere(
      (c) => c.name.isEmpty,
      orElse: () => constructors.first,
    );

    final routeParams = <RouteParameter>[];
    final queryParams = <QueryParameter>[];

    for (final param in constructor.parameters) {
      if (param.name == 'key') continue; // Skip Flutter's key parameter

      final paramType = param.type.getDisplayString();
      final isRequired =
          param.isRequired || (!param.isOptional && !param.hasDefaultValue);
      final isNullable = param.type.isDartCoreNull || paramType.endsWith('?');

      // Determine if this should be a route parameter or query parameter
      if (isRequired && !isNullable) {
        // Required non-nullable parameters become route parameters
        routeParams.add(RouteParameter(
          name: param.name,
          type: paramType.replaceAll('?', ''),
          isRequired: true,
        ));
      } else {
        // Optional/nullable parameters become query parameters
        queryParams.add(QueryParameter(
          name: param.name,
          type: paramType,
          isRequired: isRequired,
          defaultValue: param.hasDefaultValue ? param.defaultValueCode : null,
        ));
      }
    }

    return ParameterAnalysis(
      routeParameters: routeParams,
      queryParameters: queryParams,
    );
  }
}

/// Analysis result containing detected parameters
class ParameterAnalysis {
  final List<RouteParameter> routeParameters;
  final List<QueryParameter> queryParameters;

  const ParameterAnalysis({
    required this.routeParameters,
    required this.queryParameters,
  });

  factory ParameterAnalysis.empty() => const ParameterAnalysis(
        routeParameters: [],
        queryParameters: [],
      );

  bool get hasParameters =>
      routeParameters.isNotEmpty || queryParameters.isNotEmpty;
}

/// Route parameter information
class RouteParameter {
  final String name;
  final String type;
  final bool isRequired;

  const RouteParameter({
    required this.name,
    required this.type,
    required this.isRequired,
  });

  /// Convert to path parameter format (e.g., "id" -> ":id")
  String get pathParam => ':$name';

  /// Generate parameter parsing code
  String generateParsingCode() {
    switch (type) {
      case 'int':
        return 'int.parse(state.pathParameters[\'$name\']!)';
      case 'double':
        return 'double.parse(state.pathParameters[\'$name\']!)';
      case 'bool':
        return 'state.pathParameters[\'$name\'] == \'true\'';
      default:
        return 'state.pathParameters[\'$name\']!';
    }
  }
}

/// Query parameter information
class QueryParameter {
  final String name;
  final String type;
  final bool isRequired;
  final String? defaultValue;

  const QueryParameter({
    required this.name,
    required this.type,
    required this.isRequired,
    this.defaultValue,
  });

  /// Generate query parameter parsing code
  String generateParsingCode() {
    final baseType = type.replaceAll('?', '');
    final queryAccess = 'state.uri.queryParameters[\'$name\']';

    if (!isRequired && !type.endsWith('?')) {
      // Optional parameter with default value
      final defaultVal = defaultValue ?? _getDefaultForType(baseType);
      return '$queryAccess != null ? ${_parseValue(baseType, queryAccess)} : $defaultVal';
    } else if (type.endsWith('?')) {
      // Nullable parameter
      return '$queryAccess != null ? ${_parseValue(baseType, queryAccess)} : null';
    } else {
      // Required parameter
      return _parseValue(baseType, '$queryAccess!');
    }
  }

  String _parseValue(String type, String valueExpression) {
    switch (type) {
      case 'int':
        return 'int.parse($valueExpression)';
      case 'double':
        return 'double.parse($valueExpression)';
      case 'bool':
        return '$valueExpression == \'true\'';
      default:
        return valueExpression;
    }
  }

  String _getDefaultForType(String type) {
    switch (type) {
      case 'int':
        return '0';
      case 'double':
        return '0.0';
      case 'bool':
        return 'false';
      case 'String':
        return "''";
      default:
        return 'null';
    }
  }
}
