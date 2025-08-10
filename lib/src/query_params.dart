import 'package:meta/meta.dart';

/// Base class for type-safe query parameter definitions.
abstract class QueryParams {
  /// Creates query parameters.
  const QueryParams();

  /// Converts query parameters to a map.
  Map<String, String> toMap();

  /// Creates query parameters from a map.
  static T fromMap<T extends QueryParams>(Map<String, String> params) {
    throw UnimplementedError('Subclasses must implement fromMap');
  }
}

/// Example query parameters for product listing.
@immutable
class ProductQueryParams extends QueryParams {
  /// Creates product query parameters.
  const ProductQueryParams({
    this.category,
    this.minPrice,
    this.maxPrice,
    this.sortBy = 'name',
    this.page = 1,
  });

  /// Product category filter.
  final String? category;

  /// Minimum price filter.
  final double? minPrice;

  /// Maximum price filter.
  final double? maxPrice;

  /// Sort field.
  final String sortBy;

  /// Page number for pagination.
  final int page;

  @override
  Map<String, String> toMap() {
    final map = <String, String>{};
    if (category != null) map['category'] = category!;
    if (minPrice != null) map['minPrice'] = minPrice!.toString();
    if (maxPrice != null) map['maxPrice'] = maxPrice!.toString();
    map['sortBy'] = sortBy;
    map['page'] = page.toString();
    return map;
  }

  /// Creates product query parameters from a map.
  static ProductQueryParams fromMap(Map<String, String> params) {
    return ProductQueryParams(
      category: params['category'],
      minPrice: double.tryParse(params['minPrice'] ?? ''),
      maxPrice: double.tryParse(params['maxPrice'] ?? ''),
      sortBy: params['sortBy'] ?? 'name',
      page: int.tryParse(params['page'] ?? '1') ?? 1,
    );
  }
}

/// Annotation for specifying query parameter types for a route.
///
/// Example:
/// ```dart
/// @QueryParameterType(ProductQueryParams)
/// class ProductListPage extends StatelessWidget {
///   const ProductListPage({super.key, required this.queryParams});
///
///   final ProductQueryParams queryParams;
///   // ...
/// }
/// ```
@immutable
class QueryParameterType {
  /// Creates query parameter type annotation.
  const QueryParameterType(this.type);

  /// The type of query parameters for this route.
  final Type type;
}

/// Enhanced navigation helpers with query parameter support.
extension QueryParamNavigation on Type {
  /// Navigate with type-safe query parameters.
  static void goToWithQuery<T extends QueryParams>(
    String route,
    T queryParams,
  ) {
    final uri = Uri(path: route, queryParameters: queryParams.toMap());
    // This would typically use go_router's context.go() method
    // For now, we provide the implementation structure
    throw UnimplementedError('Use context.go("${uri.toString()}") in your app');
  }

  /// Push with type-safe query parameters.
  static void pushToWithQuery<T extends QueryParams>(
    String route,
    T queryParams,
  ) {
    final uri = Uri(path: route, queryParameters: queryParams.toMap());
    // This would typically use go_router's context.push() method  
    // For now, we provide the implementation structure
    throw UnimplementedError('Use context.push("${uri.toString()}") in your app');
  }
}
