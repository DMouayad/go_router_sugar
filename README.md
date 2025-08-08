# 🍬 Go Router Sugar

![Pub Version](https://img.shields.io/pub/v/go_router_sugar)
![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)

**Zero-effort file-based routing for Flutter** that automatically generates your `go_router` configuration from your file structure. No more boilerplate, no more manual route definitions, and now with **beautiful page transitions**!

Tired of writing and maintaining dozens of lines of `GoRoute` configuration? Go Router Sugar automates this entire process. Simply organize your pages as files, and let the generator do the rest.

## ✅ Compatibility

- Dart SDK: >=3.0.0 <4.0.0  
- Flutter: >=3.10.0

## 🔥 The "Before" and "After" Transformation

Transform your Flutter app routing from complex configuration to intuitive file organization.

### ❌ Before: Manual `go_router` Configuration
```dart
// 50+ lines of repetitive GoRoute configuration
GoRouter(
  routes: [
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!; // Runtime error risk!
        return ProductPage(id: id);
      },
    ),
    GoRoute(
      path: '/user/profile/settings',
      builder: (context, state) => const UserProfileSettingsPage(),
    ),
    // ...endless boilerplate for every route
  ],
);

// String-based navigation (typo = crash!)
context.go('/prodcuts/123'); // Oops! Typo = runtime error
```

### ✅ After: Effortless File-Based Magic

```bash
# Your file system IS your route map.
lib/pages/
├── products/[id]_page.dart         → /products/:id
├── user/profile/settings_page.dart → /user/profile/settings
└── home_page.dart                  → /home
```

```dart
// Use the generated router instantly.
MaterialApp.router(routerConfig: AppRouter.router);

// Navigate with 100% type-safety.
Navigate.goToProductsId(id: '123');     // ✅ No typos possible!
Navigate.goToUserProfileSettings();     // ✅ IntelliSense autocomplete!
```

### 🚀 The Result: 90% Less Code, 100% More Safety

  - **5 minutes setup** vs. hours of manual configuration.
  - **Zero boilerplate** - your file system is your route map.
  - **Type-safe navigation** - impossible to make typo errors.
  - **Beautiful transitions** - professional animations with one line of code.
  - **Hot reload friendly** - changes reflect instantly with watch mode.

-----

## 🚀 Quick Start

### 1. Installation

Add `go_router` and `go_router_sugar` to your `pubspec.yaml`.

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^16.1.0

dev_dependencies:
  build_runner: ^2.4.9
  go_router_sugar: ^1.0.0
```

### 2. Create Your Pages

Create your page files in `lib/pages/` (or your preferred directory). Page files must end with `_page.dart`.

```
lib/
├── pages/
│   ├── home_page.dart              # Route: /home
│   └── products/
│       └── [id]_page.dart          # Dynamic route: /products/:id
└── main.dart
```

**Simple page example** (`lib/pages/home_page.dart`):

```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Welcome Home!'),
      ),
    );
  }
}
```

**Page with parameters** (`lib/pages/products/[id]_page.dart`):

```dart
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String id;

  const ProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $id')),
      body: Center(
        child: Text('Displaying product with ID: $id'),
      ),
    );
  }
}
```

### 3. Generate Your Routes

Run the code generator to create your `app_router.g.dart` file.

**🌟 Option 1: Use the Simple CLI (Recommended)**

Our package includes a simple command-line tool (CLI) that makes generation easy. It's a convenient wrapper around the standard Dart build system.

```bash
# Run the generator once
dart run go_router_sugar

# Watch for file changes (perfect for development)
dart run go_router_sugar_watch
```

**💡 Why `dart run`?** It runs the version pinned in your project, avoiding global version drift across teammates.

-----

**⚙️ Option 2: Use the Standard Dart Build Runner**

If you're already using `build_runner` for other packages, you can use the standard commands.

```bash
# Run the generator once
dart run build_runner build --delete-conflicting-outputs

# Watch for file changes
dart run build_runner watch --delete-conflicting-outputs
```

### 4. Use the Generated Router

In your `main.dart`, import the generated file and configure your `MaterialApp.router`.

```dart
import 'package:flutter/material.dart';
import 'app_router.g.dart'; // Generated file

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerConfig: AppRouter.router,
    );
  }
}
```

### 5. Navigate with Type-Safety

Forget string-based paths and runtime errors. Use the generated, type-safe navigation helpers for 100% safety and IDE autocomplete.

```dart
import 'package:flutter/material.dart';
import 'app_router.g.dart'; // Import the generated file

// Option 1: Static Navigate class (simple and direct)
Navigate.goToHome();
Navigate.pushToProductsId(id: 'abc-123');

// Option 2: GoRouter/BuildContext extension methods (fluent and idiomatic)
context.goToHome();
context.pushToProductsId(id: 'abc-123');
```

While you *can* still use raw strings with the generated `Routes` constants (`context.go(Routes.home)`), the navigation helpers are the recommended, safer approach.

-----

## ✨ Features

  - 🚀 **Zero Boilerplate**: Automatically generates `GoRouter` configuration.
  - 📁 **File-Based Routing**: Your file system becomes your route map.
  - 🎨 **Rich Page Transitions**: 15+ built-in transition types with zero effort.
  - 🔧 **Highly Configurable**: Customize directories, naming conventions, transitions, and output.
  - 🛡️ **Type-Safe Navigation**: Generated navigation helpers prevent runtime errors.
  - ⚡ **Dynamic Routes**: Built-in support for path parameters using `[param]` syntax.
  - 🎯 **Flutter-First**: Designed specifically for Flutter's ecosystem.
  - 📱 **Hot Reload Friendly**: Works seamlessly with Flutter's development workflow.
  - 🎭 **Per-Page Transitions**: Configure transitions individually for each page.
  - 🔐 **Route Guards**: Built-in authentication and permission guards using annotations.
  - 🗂️ **Shell Routes**: Automatic layout detection for nested navigation.
  - 📊 **Query Parameters**: Type-safe query parameter handling.
  - 📈 **Analytics**: Built-in route analytics and performance monitoring.
  - 🛠️ **CLI Tool**: Simple command-line tool for generation.
  - 🔌 **VS Code Extension (Planned)**: Rich IDE integration with IntelliSense and code actions.

-----

## 🎨 Page Transitions

Go Router Sugar includes a comprehensive transition system with 10+ built-in animation types.

### Available Transition Types

| Transition | Description | Use Case |
|------------|-------------|----------|
| `platform` | Platform-specific default | Most pages (follows iOS/Android conventions) |
| `fade` | Smooth fade in/out | Modal dialogs, overlays |
| `slideRight` | Slide from right to left | Forward navigation (iOS style) |
| `slideLeft` | Slide from left to right | Back navigation, reverse flow |
| `slideUp` | Slide from bottom to top | Modal sheets, bottom navigation |
| `slideDown`| Slide from top to bottom | Notifications, dropdown menus |
| `scale` | Scale up from center | Pop-up effects, emphasis |
| `rotation` | Rotate while transitioning | Creative transitions, games |
| `size` | Size-based transition | Zoom effects, focus changes |
| `slideAndFade` | Combined slide + fade | Elegant page transitions |
| `none` | No animation | Instant navigation, performance |

### Using Transitions

Annotate your page widget with `@PageTransition` to specify an animation.

```dart
import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

// Use a simple preset
@PageTransition(TransitionConfig.fade)
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  // ... widget implementation
}

// Customize the transition
@PageTransition(TransitionConfig(
  type: PageTransitionType.slideUp,
  duration: Duration(milliseconds: 400),
  curve: Curves.easeInOutCubic,
))
class ModalPage extends StatelessWidget {
  const ModalPage({super.key});
  // ... widget implementation
}
```

-----

## 🔧 Configuration

Customize the generator's behavior using CLI flags or a `build.yaml` file.

**Method 1: CLI Flags (Recommended for one-offs)**

Use command-line flags for quick, temporary changes.

```bash
# Generate with a custom pages directory
dart run go_router_sugar --pages-dir lib/screens

# Specify a different output file
dart run go_router_sugar --output lib/config/app_routes.g.dart

# Combine flags
dart run go_router_sugar --pages-dir lib/views -o lib/my_router.g.dart
```

**Method 2: `build.yaml` (Recommended for teams/projects)**

For permanent configuration that you can commit to version control, create a `build.yaml` file in your project root. This is the best way to ensure your entire team uses the same settings.

```yaml
targets:
  $default:
    builders:
      go_router_sugar|routes:
        options:
          # Directory containing your page files.
          pages_directory: "lib/pages"
          
          # Whether to generate type-safe navigation helpers.
          generate_navigation_helpers: true
          
          # Name of the generated router class.
          router_class_name: "AppRouter"
          
          # Output file path.
          output_file: "lib/app_router.g.dart"
```

-----

## 📝 File Naming Conventions

  - Page files must end with `_page.dart`.
  - Dynamic parameters use square brackets: `[id]_page.dart`, `[slug]_page.dart`.
  - Nested routes follow your directory structure.

| File Path | Generated Route |
|-----------|-----------------|
| `lib/pages/home_page.dart` | `/home` |
| `lib/pages/user/profile_page.dart`| `/user/profile` |
| `lib/pages/products/[id]_page.dart`| `/products/:id` |
| `lib/pages/blog/[year]/[month]_page.dart` | `/blog/:year/:month`|

## 🛠️ Generated Code

The generator creates a single file (`app_router.g.dart`) with several helpful utilities.

#### 1. Router Configuration

A ready-to-use `GoRouter` instance.

```dart
class AppRouter {
  static final GoRouter router = GoRouter(routes: [...]);
}
```

#### 2. Route Constants

String constants for all your routes.

```dart
abstract class Routes {
  static const String home = '/home';
  static const String productsId = '/products/:id';
  // ... more routes
}
```

#### 3. Type-Safe Navigation

Static methods and extension methods for safe, easy navigation.

```dart
// Static helper class
class Navigate {
  static void goToHome() => AppRouter.router.go('/home');
  static void pushToProductsId({required String id}) => 
    AppRouter.router.push('/products/$id');
}

// Extension on GoRouter/BuildContext
extension AppRouterNavigation on GoRouter {
  void goToHome() => go('/home');
  void pushToProductsId({required String id}) => push('/products/$id');
}
```

-----

## 🧪 Example Projects

Explore our examples to see the package in action.

### Minimal Example (Quick Start)

Demonstrates basic file-based routing.

```bash
cd example/minimal
flutter pub get
dart run go_router_sugar
flutter run
```

### Full Example (All Features)

Showcases advanced features like transitions, guards, and nested routing.

```bash
cd example
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## 🤝 Contributing

Contributions are welcome! Please see our Contributing Guide for details on how to submit pull requests and report issues.

## 📄 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

## 🙋‍♂️ Support

  - 📖 **Documentation**: https://github.com/mukhbit0/go_router_sugar
  - 🐛 **Issue Tracker**: https://github.com/mukhbit0/go_router_sugar/issues
  - 💬 **Discussions**: https://github.com/mukhbit0/go_router_sugar/discussions

-----

Made with ❤️ for the Flutter community.