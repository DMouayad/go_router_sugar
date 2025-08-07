# 🍬 Go Router Sugar

![Pub Version](https://img.shields.io/pub/v/go_router_sugar)
![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)

**Zero-effort file-based routing for Flutter** that automatically generates your `go_router` configuration from your file structure. No more boilerplate, no more manual route definitions, and now with **beautiful page transitions**!

## 🔥 **File-Based Routing Revolution**

Transform your Flutter app routing from **complex configuration hell** to **intuitive file organization**:

### **❌ Before: Manual go_router Hell**
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

### **✅ After: Effortless File-Based Magic**
```bash
# Just create files - routes are auto-generated!
lib/pages/
├── products/[id]_page.dart     → /products/:id
├── user/profile/settings_page.dart → /user/profile/settings
└── home_page.dart              → /home

# Generate perfect router code with one command!
dart pub global activate go_router_sugar
go_router_sugar
```

```dart
// Type-safe navigation (autocomplete + compile-time safety!)
Navigate.goToProductsId(id: '123');     // ✅ No typos possible!
Navigate.goToUserProfileSettings();     // ✅ IntelliSense autocomplete!

// Use generated router instantly
MaterialApp.router(routerConfig: AppRouter.router);
```

### **🚀 The Result: 90% Less Code, 100% More Safety**

- **5 minutes setup** vs 2 hours of manual configuration
- **Zero boilerplate** - your file system IS your route map
- **Type-safe navigation** - impossible to make typo errors
- **Beautiful transitions** - professional animations with one line
- **Hot reload friendly** - changes reflect instantly

## 🎯 Usage Guide: Simple vs Advanced

### 🌟 **SIMPLE** (90% of developers - recommended start)

**Just want file-based routing? Start here!**

```dart
// 1. Create pages in lib/pages/
lib/pages/home_page.dart
lib/pages/about_page.dart
lib/pages/products/[id]_page.dart

// 2. Generate routes
dart pub global activate go_router_sugar
go_router_sugar

// 3. Done! Type-safe navigation ready
Navigate.goToHome();
Navigate.goToProductsId(id: '123');
```

### ⚡ **ADVANCED** (10% of developers - enterprise features)

**Need guards, analytics, custom transitions? Add these:**

```dart
@RouteGuards([AuthGuard()])
@PageTransition(TransitionConfig.slideRight)
@RouteAnalytics(trackPageViews: true)
class PremiumPage extends StatelessWidget { ... }
```

---

## ✨ Features

- 🚀 **Zero Boilerplate**: Automatically generates `GoRouter` configuration
- 📁 **File-Based Routing**: Your file system becomes your route map
- 🎨 **Rich Page Transitions**: 15+ built-in transition types with zero effort
- 🔧 **Highly Configurable**: Customize directories, naming conventions, transitions, and output
- 🛡️ **Type-Safe Navigation**: Generated navigation helpers prevent runtime errors
- ⚡ **Dynamic Routes**: Built-in support for path parameters using `[param]` syntax
- 🎯 **Flutter-First**: Designed specifically for Flutter's ecosystem
- 📱 **Hot Reload Friendly**: Works seamlessly with Flutter's development workflow
- 🎭 **Per-Page Transitions**: Configure transitions individually for each page
- 🔐 **Route Guards**: Built-in authentication and permission guards
- 🗂️ **Shell Routes**: Automatic layout detection for nested navigation
- 📊 **Query Parameters**: Type-safe query parameter handling
- 📈 **Analytics**: Built-in route analytics and performance monitoring
- 🛠️ **CLI Tool**: Command-line tool for scaffolding and page generation
- 🔌 **VS Code Extension**: Rich IDE integration with IntelliSense and code actions

## 🚀 Quick Start

### 1. Installation

Add to your `pubspec.yaml`:

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

Create your page files in `lib/pages/` (or your preferred directory):

```dart
lib/
├── pages/
│   ├── home_page.dart
│   ├── about_page.dart
│   ├── profile/
│   │   └── settings_page.dart
│   └── products/
│       ├── [id]_page.dart        # Dynamic route: /products/:id
│       └── list_page.dart
└── main.dart
```

**Basic page example** (`lib/pages/products/[id]_page.dart`):

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

**Page with custom transition** (`lib/pages/animated_page.dart`):

```dart
import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

@PageTransition(TransitionConfig.slideRight)
class AnimatedPage extends StatelessWidget {
  const AnimatedPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Page')),
      body: const Center(
        child: Text('This page slides in from the right!'),
      ),
    );
  }
}
```

### 3. Generate Routes

**🌟 Easy way** (recommended):

```bash
# Install globally once
dart pub global activate go_router_sugar

# Basic usage with default lib/pages directory
go_router_sugar

# Custom pages directory
go_router_sugar --pages-dir lib/screens

# Custom directory and output file
go_router_sugar -d lib/views -o lib/my_router.g.dart

# Watch for changes (auto-regenerates)
go_router_sugar_watch --watch --pages-dir lib/screens
```

**⚙️ Traditional way**:

```bash
dart run build_runner build
```

**💡 Pro tip**: Use watch mode during development for instant updates!

### 4. Use the Generated Router

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

### 5. Navigate with Type Safety

```dart
// Using generated navigation helpers
Navigate.goToHome();
Navigate.pushToProductsId(id: 'abc-123');

// Using GoRouter extensions
context.goToAbout();
context.pushToProfileSettings();

// Using route constants
context.go(Routes.home);
context.push(Routes.productsId.replaceAll(':id', 'abc-123'));
```

## 🎨 Page Transitions

Go Router Sugar includes a comprehensive transition system with **10+ built-in animation types**. Developers can choose from various transitions with zero configuration effort!

### Available Transition Types

| Transition | Description | Use Case |
|------------|-------------|----------|
| `platform` | Platform-specific default | Most pages (follows iOS/Android conventions) |
| `fade` | Smooth fade in/out | Modal dialogs, overlays |
| `slideRight` | Slide from right to left | Forward navigation (iOS style) |
| `slideLeft` | Slide from left to right | Back navigation, reverse flow |
| `slideUp` | Slide from bottom to top | Modal sheets, bottom navigation |
| `slideDown` | Slide from top to bottom | Notifications, dropdown menus |
| `scale` | Scale up from center | Pop-up effects, emphasis |
| `rotation` | Rotate while transitioning | Creative transitions, games |
| `size` | Size-based transition | Zoom effects, focus changes |
| `slideAndFade` | Combined slide + fade | Elegant page transitions |
| `none` | No animation | Instant navigation, performance |

### Using Transitions

#### Method 1: Page-Level Annotations (Recommended)

```dart
import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

// Fade transition with custom duration
@PageTransition(TransitionConfig.fade)
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  // ... widget implementation
}

// Slide transition with custom configuration
@PageTransition(TransitionConfig(
  type: PageTransitionType.slideUp,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
))
class ModalPage extends StatelessWidget {
  const ModalPage({super.key});
  // ... widget implementation
}

// Quick preset configurations
@PageTransition(TransitionConfig.slideRight)  // iOS-style push
@PageTransition(TransitionConfig.scale)       // Pop-up effect
@PageTransition(TransitionConfig.none)        // No animation
```

#### Method 2: Custom Transition Configs

```dart
// Create your own transition configurations
class MyTransitions {
  static const fastFade = TransitionConfig(
    type: PageTransitionType.fade,
    duration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );
  
  static const bouncySlide = TransitionConfig(
    type: PageTransitionType.slideRight,
    duration: Duration(milliseconds: 500),
    curve: Curves.bounceOut,
  );
}

@PageTransition(MyTransitions.fastFade)
class QuickPage extends StatelessWidget {
  // ... implementation
}
```

### Transition Configuration Options

```dart
class TransitionConfig {
  final PageTransitionType type;
  final Duration duration;          // Default: 250ms
  final Curve curve;               // Default: Curves.easeInOut
  
  const TransitionConfig({
    required this.type,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
  });
}
```

## 🔧 Configuration

### CLI Options (Recommended)

**Generate with custom settings:**

```bash
# Install globally once (one-time setup)
dart pub global activate go_router_sugar

# Custom pages directory
go_router_sugar --pages-dir lib/screens

# Custom output file  
go_router_sugar --output lib/my_router.g.dart

# Both custom directory and output
go_router_sugar -d lib/views -o lib/app_routes.g.dart

# Watch mode with custom settings
go_router_sugar_watch --watch --pages-dir lib/screens
```

**Common directory patterns:**

- `lib/pages/` - Default (recommended)
- `lib/screens/` - Alternative naming  
- `lib/views/` - MVC pattern
- `lib/ui/pages/` - Nested structure

### Manual Configuration (build.yaml)

Create a `build.yaml` file in your project root to customize the generator:

```yaml
targets:
  $default:
    builders:
      go_router_sugar|routes:
        options:
          # Directory containing your page files
          pages_directory: "lib/screens"
          
          # Whether to generate type-safe navigation helpers
          generate_navigation_helpers: true
          
          # Name of the generated router class
          router_class_name: "AppRouter"
          
          # Output file path
          output_file: "lib/my_router.g.dart"
```

## 📝 File Naming Conventions

- Page files must end with `_page.dart`
- Dynamic parameters use square brackets: `[id]_page.dart`, `[category]_page.dart`
- Nested routes follow your directory structure

### Examples

| File Path | Generated Route | Widget Class |
|-----------|----------------|--------------|
| `lib/pages/home_page.dart` | `/home` | `HomePage` |
| `lib/pages/user/profile_page.dart` | `/user/profile` | `UserProfilePage` |
| `lib/pages/products/[id]_page.dart` | `/products/:id` | `ProductPage` |
| `lib/pages/blog/[year]/[month]_page.dart` | `/blog/:year/:month` | `BlogYearMonthPage` |

## 🛠️ Generated Code

The generator creates several helpful utilities:

### 1. Router Configuration

```dart
class AppRouter {
  static final GoRouter instance = GoRouter(routes: [...]);
  static GoRouter get router => instance;
}
```

### 2. Route Constants

```dart
abstract class Routes {
  static const String home = '/home';
  static const String productsId = '/products/:id';
  // ... more routes
}
```

### 3. Type-Safe Navigation

```dart
class Navigate {
  static void goToHome() => AppRouter.instance.go('/home');
  static void pushToProductsId({required String id}) => 
    AppRouter.instance.push('/products/$id');
}

extension AppRouterNavigation on GoRouter {
  void goToHome() => go('/home');
  void pushToProductsId({required String id}) => push('/products/$id');
}
```

## 📱 Advanced Usage

### Custom Page Classes

Your page widgets can have any constructor signature. The generator will automatically pass path parameters:

```dart
class UserPage extends StatelessWidget {
  final String userId;
  final String? tab; // Optional parameters work too
  
  const UserPage({
    super.key,
    required this.userId,
    this.tab,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User: $userId')),
      body: tab != null
        ? Text('Tab: $tab')
        : const Text('Default view'),
    );
  }
}
```

### Nested Navigation

Create complex nested routes by organizing your files:

```dart
lib/pages/
├── dashboard/
│   ├── dashboard_page.dart       # /dashboard
│   ├── analytics/
│   │   └── analytics_page.dart   # /dashboard/analytics
│   └── settings/
│       └── settings_page.dart    # /dashboard/settings
```

### Integration with GoRouter Features

The generated router is fully compatible with GoRouter's features:

```dart
class AppRouter {
  static final GoRouter instance = GoRouter(
    routes: [...], // Generated routes
    
    // Add your custom configuration
    initialLocation: '/home',
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) {
      // Add authentication logic
      if (!isLoggedIn && state.location != '/login') {
        return '/login';
      }
      return null;
    },
  );
}
```

## 🧪 Example Projects

### Minimal Example (Quick Start)

Check out the minimal example to see basic file-based routing in action:

```bash
cd example/minimal
flutter pub get
dart pub global activate go_router_sugar
go_router_sugar
flutter run
```

**What's included:**

- Just 2 simple pages (`home_page.dart`, `about_page.dart`)
- Clean setup with zero advanced features
- Perfect for understanding the basics

### Full Example (All Features)

Explore the complete example with all advanced features:

```bash
cd example
flutter pub get
dart run build_runner build
flutter run
```

**What's included:**

- Multiple page types and transitions
- Advanced features (guards, analytics, custom directories)
- Complex routing scenarios
- Production-ready patterns

## 🔄 Development Workflow

### Watch Mode

For continuous generation during development:

```bash
go_router_sugar_watch --watch
```

### Clean Build

To regenerate all files:

```bash
dart run build_runner clean
dart run build_runner build
```

### IDE Integration

Most IDEs will automatically run the generator when you save files. You can also set up file watchers for seamless development.

## 🤝 Contributing

We welcome contributions! Please see our Contributing Guide for details.

### Development Setup

1. Clone the repository
2. Run `flutter pub get`
3. Make your changes
4. Run tests: `dart test`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙋‍♂️ Support

- 📖 [Documentation](https://github.com/yourusername/go_router_sugar)
- 🐛 [Issue Tracker](https://github.com/yourusername/go_router_sugar/issues)
- 💬 [Discussions](https://github.com/yourusername/go_router_sugar/discussions)

---

Made with ❤️ for the Flutter community
