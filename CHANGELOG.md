# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
