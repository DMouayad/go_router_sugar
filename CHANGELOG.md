# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-08-08

### 🚀 The Zero-Ambiguity Revolution

**Major Update**: Transformed go_router_sugar into the ultimate zero-ambiguity Flutter routing solution. Every feature designed to eliminate confusion, reduce code, and prevent errors.

### ⚡ New: Instant App Creation

- **Revolutionary CLI**: Create complete Flutter apps in seconds with `dart run go_router_sugar new`
- **Smart Templates**: Choose from minimal, ecommerce, or auth templates
- **Zero Setup**: Apps come with full routing, navigation, and example pages pre-configured
- **Production Ready**: Generated apps follow Flutter best practices

```bash
dart run go_router_sugar new my_app --template ecommerce
cd my_app && flutter run  # Complete shopping app ready!
```

### 🧠 New: Smart Parameter Detection (Zero Configuration)

- **Constructor Analysis**: Your constructor parameters automatically become route parameters
- **Intelligent Parameter Mapping**: Required params → Path params, Optional params → Query params
- **Type-Safe Parsing**: Automatic parsing for `String`, `int`, `bool`, `double` types
- **Null Safety**: Perfect integration with Dart's null safety
- **Zero Configuration**: No annotations, no setup - just write normal constructors

```dart
class ProductPage extends StatelessWidget {
  final String productId;    // Auto-becomes /products/:productId  
  final String? category;    // Auto-becomes ?category=value
  final int? page;          // Auto-parsed from ?page=1
  final bool featured;      // Auto-parsed from ?featured=true
  
  const ProductPage({
    super.key,
    required this.productId,  // Required = Path parameter
    this.category,            // Optional = Query parameter
    this.page,               // Nullable = Optional query
    this.featured = false,   // Default = Optional with fallback
  });
}
```

### 🛡️ New: Zero-Config Route Guards

- **Simple Interface**: Implement `RouteGuard` interface for instant auth protection
- **Annotation-Based**: Use `@Protected([GuardClass])` for one-line route protection
- **Flexible Guards**: Support for auth guards, role guards, and custom logic
- **Automatic Integration**: Guards automatically integrated into generated routes
- **Zero Boilerplate**: No manual route configuration needed

```dart
class AuthGuard implements RouteGuard {
  @override
  bool canAccess(BuildContext context, GoRouterState state) {
    return UserService.isLoggedIn;
  }
  
  @override
  String get redirectPath => '/login';
}

@Protected([AuthGuard])
class ProfilePage extends StatelessWidget {
  // Page automatically protected - zero configuration!
}
```

### 🎨 Enhanced CLI Experience

- **Comprehensive Help**: Professional help system with examples and patterns
- **Template System**: Pre-built app templates for instant productivity
- **Smart Defaults**: Intelligent default values for all options
- **Error Handling**: Improved error messages and recovery suggestions
- **Cross-Platform**: Works seamlessly on Windows, macOS, and Linux

### 🏗️ Architecture Improvements

- **Enhanced Code Generation**: Cleaner, more efficient generated code
- **Better Error Handling**: Specific exception types for better debugging
- **Improved Type Safety**: Enhanced compile-time safety throughout
- **Performance Optimizations**: Faster build times and smaller generated files
- **Code Quality**: Comprehensive linting and code style improvements

### 🔧 Technical Updates

- **Dependencies**: Updated to latest analyzer, build, and source_gen packages
- **Linting**: Custom analysis options for package-appropriate standards
- **Documentation**: Comprehensive inline documentation for all features
- **Testing**: Enhanced test coverage for all new features
- **Examples**: Updated examples showcasing all zero-ambiguity features

### 📦 Migration Guide

**From 1.0.x to 1.1.0:**

1. **Smart Parameter Detection**: Your existing constructors will automatically work with the new parameter detection. No changes needed!

2. **Route Guards**: If you were using experimental guards, update to the new interface:
   ```dart
   // Old (experimental)
   class AuthGuard extends RouteGuard { ... }
   
   // New (stable)
   class AuthGuard implements RouteGuard { ... }
   ```

3. **CLI**: New commands are available but existing build_runner workflow still works perfectly.

### 🎯 Breaking Changes

- **None**: This is a backward-compatible update. All existing code continues to work.

## [1.0.0] - 2025-08-07

### 🎉 Initial Release - The Flutter File-Based Routing Revolution

**Zero-effort file-based routing for Flutter** that automatically generates your `go_router` configuration from your file structure.

### ✨ Core Features

- **📁 File-Based Routing**: Your file system becomes your route map
- **🚀 Zero Boilerplate**: No manual GoRoute configuration needed  
- **🛡️ Type-Safe Navigation**: Auto-generated navigation helpers prevent runtime errors
- **⚡ Dynamic Routes**: Built-in support for path parameters using `[param]` syntax
- **🎨 Page Transitions**: 15+ built-in animation types (fade, slide, scale, rotation, etc.)
- **🔧 Highly Configurable**: Custom directories, naming conventions, and output options
- **📱 Hot Reload Friendly**: Works seamlessly with Flutter's development workflow

### 🛠️ Developer Tools

- **CLI Commands**: `go_router_sugar` and `go_router_sugar_watch` for easy generation
- **Custom Directory Support**: `--pages-dir lib/screens` for flexible project structures
- **Watch Mode**: Auto-regeneration on file changes for development workflow
- **Professional Help**: Comprehensive `--help` output with examples and common patterns

### 🎭 Advanced Features

- **Page Transitions**: Per-page transition configuration with `@PageTransition` annotation
- **Route Guards**: Authentication and permission guards (experimental)  
- **Shell Routes**: Automatic layout detection for nested navigation
- **Query Parameters**: Type-safe query parameter handling (experimental)
- **Analytics**: Built-in route analytics and performance monitoring (experimental)

### 📚 Documentation & Examples

- **Comprehensive README**: File-based routing revolution showcase with before/after examples
- **Minimal Example**: Simple 2-page app demonstrating basic file-based routing
- **Full Example**: Complete showcase with all features and advanced patterns
- **Professional CLI**: Help system with common directory patterns and usage examples

### 🔧 Technical Implementation

- **Robust Code Generation**: Uses `build_runner` for reliable, incremental builds
- **Clean Generated Code**: Proper imports, documentation, and Flutter conventions
- **Type Safety**: Full compile-time safety with autocomplete support
- **Extension Methods**: Convenient navigation extensions for `GoRouter` and `BuildContext`
- **Route Constants**: Generated constants for consistent route referencing

### 📦 Package Quality

- **Zero Analyzer Errors**: Clean, maintainable codebase following Dart conventions
- **Comprehensive Tests**: Full test coverage for core functionality
- **Professional Documentation**: Clear examples, API docs, and usage patterns
- **MIT Licensed**: Open source and community-friendly

### 🚀 Getting Started

```bash
# Install globally
dart pub global activate go_router_sugar

# Create your pages
lib/pages/home_page.dart
lib/pages/products/[id]_page.dart

# Generate routes
go_router_sugar

# Use type-safe navigation
Navigate.goToHome();
Navigate.goToProductsId(id: '123');
```

### 🎯 What's Next

This initial release establishes **go_router_sugar** as the definitive solution for file-based routing in Flutter. Future releases will expand the experimental features and add enterprise-grade capabilities.

---

*Transform your Flutter app routing from complex configuration hell to intuitive file organization!*
