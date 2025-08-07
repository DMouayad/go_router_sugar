import 'package:go_router_sugar/src/route_info.dart';
import 'package:test/test.dart';

void main() {
  group('RouteInfo', () {
    test('creates route info from file path correctly', () {
      final routeInfo = RouteInfo.fromPath(
        'lib/pages/home_page.dart',
        'lib/pages',
      );

      expect(routeInfo.filePath, equals('lib/pages/home_page.dart'));
      expect(routeInfo.routePath, equals('/home'));
      expect(routeInfo.className, equals('HomePage'));
      expect(routeInfo.parameters, isEmpty);
      expect(routeInfo.hasDynamicParams, isFalse);
    });

    test('handles dynamic routes correctly', () {
      final routeInfo = RouteInfo.fromPath(
        'lib/pages/products/[id]_page.dart',
        'lib/pages',
      );

      expect(routeInfo.filePath, equals('lib/pages/products/[id]_page.dart'));
      expect(routeInfo.routePath, equals('/products/:id'));
      expect(routeInfo.className, equals('ProductsIdPage'));
      expect(routeInfo.parameters, hasLength(1));
      expect(routeInfo.parameters.first.name, equals('id'));
      expect(routeInfo.hasDynamicParams, isTrue);
    });

    test('handles nested routes correctly', () {
      final routeInfo = RouteInfo.fromPath(
        'lib/pages/user/profile/settings_page.dart',
        'lib/pages',
      );

      expect(routeInfo.filePath,
          equals('lib/pages/user/profile/settings_page.dart'));
      expect(routeInfo.routePath, equals('/user/profile/settings'));
      expect(routeInfo.className, equals('UserProfileSettingsPage'));
      expect(routeInfo.parameters, isEmpty);
    });

    test('handles multiple parameters correctly', () {
      final routeInfo = RouteInfo.fromPath(
        'lib/pages/users/[userId]/posts/[postId]_page.dart',
        'lib/pages',
      );

      expect(routeInfo.routePath, equals('/users/:userId/posts/:postId'));
      expect(routeInfo.parameters, hasLength(2));
      expect(routeInfo.parameters[0].name, equals('userId'));
      expect(routeInfo.parameters[1].name, equals('postId'));
    });
  });

  group('RouteParameter', () {
    test('creates route parameter correctly', () {
      const parameter = RouteParameter(
        name: 'id',
        isRequired: true,
        description: 'Product ID',
      );

      expect(parameter.name, equals('id'));
      expect(parameter.isRequired, isTrue);
      expect(parameter.description, equals('Product ID'));
    });

    test('has correct default values', () {
      const parameter = RouteParameter(name: 'id');

      expect(parameter.name, equals('id'));
      expect(parameter.isRequired, isTrue);
      expect(parameter.description, isNull);
    });

    test('equality works correctly', () {
      const param1 = RouteParameter(name: 'id', isRequired: true);
      const param2 = RouteParameter(name: 'id', isRequired: true);
      const param3 = RouteParameter(name: 'userId', isRequired: true);

      expect(param1, equals(param2));
      expect(param1, isNot(equals(param3)));
    });
  });
}
