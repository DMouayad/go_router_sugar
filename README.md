# 🍬 Go Router Sugar

![Pub Version](https://img.shields.io/pub/v/go_router_sugar)
![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)

**The Simplest Flutter Routing Ever** - Revolutionary CLI that transforms complex routing into simple commands and auto-magic route generation.

## 🎯 Why Go Router Sugar?

**Before:** Hours of complex routing configuration, manual route definitions, string-based navigation prone to typos.

**After:** Simple CLI commands, auto-magic route generation, beautiful visualizations, and 100% type-safe navigation!

**Every feature designed to eliminate confusion, reduce code, and prevent errors:**

- ⚡ **Instant App Creation** - Complete Flutter apps in seconds
- 🧠 **Smart Parameter Detection** - Constructor parameters = Route parameters (zero config)
- 🛡️ **Smart Route Guards** - Interface-based auth with @Protected annotation
- 📁 **File System = Route Map** - Your folder structure IS your routing
- 🔒 **100% Type Safety** - Impossible to make navigation typos
- 🎨 **Beautiful Transitions** - Professional animations with one line
- 👀 **Real-time Watch Mode** - Auto-regeneration on file changes
- 🗺️ **Visual Route Maps** - Beautiful console visualization of your routes

## ✅ Compatibility

- Dart SDK: >=3.0.0 <4.0.0  
- Flutter: >=3.10.0
- Go Router: >=10.0.0

## 🚀 Revolutionary Features

### ⚡ Instant App Creation
```bash
# Create complete Flutter apps in seconds
dart run go_router_sugar new my_app --template minimal
cd my_app && flutter run  # Complete app ready!
```

**Available templates:**
- `minimal` - Clean starter with navigation setup

### 🧠 Smart Parameter Detection (Zero Configuration!)
```dart
// ✅ Your constructor IS your route config (no setup needed!)
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
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Product $productId')),
    body: Column(children: [
      Text('Category: ${category ?? "All"}'),
      Text('Page: ${page ?? 1}'),
      Text('Featured: $featured'),
    ]),
  );
}
```

**Magic happens automatically:**
- Required parameters → Path parameters (`:productId`)
- Optional parameters → Query parameters (`?category=value`)
- Types auto-parsed (`String`, `int`, `bool`, `double`)
- Null safety respected throughout

### 🛡️ Smart Route Guards (Zero Configuration!)
```dart
// ✅ Simple interface implementation = Instant auth protection
class AuthGuard implements RouteGuard {
  @override
  Future<bool> canActivate(BuildContext context, Map<String, String> params) async {
    return UserService.isLoggedIn;
  }
  
  @override
  String? get redirectRoute => '/login';
}

// ✅ One annotation = Protected route
@Protected(AuthGuard)
class ProfilePage extends StatelessWidget {
  // Page automatically protected - zero configuration!
}
```

### 📁 File-Based Routing (Zero Boilerplate)
```bash
lib/pages/
├── products/[id]_page.dart         → /products/:id  
├── auth/login_page.dart            → /auth/login
├── user/profile/settings_page.dart → /user/profile/settings
## 🔥 The Zero-Ambiguity Advantage

### ❌ Before: Complex Manual Configuration
```dart
// 50+ lines of repetitive GoRoute configuration
GoRouter(
  routes: [
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!; // Runtime error risk!
        final category = state.uri.queryParameters['category'];
        final pageStr = state.uri.queryParameters['page'];
        final page = pageStr != null ? int.tryParse(pageStr) : null;
        return ProductPage(id: id, category: category, page: page);
      },
    ),
    // ...endless boilerplate for every route
  ],
);

// String-based navigation (typo = crash!)
context.go('/prodcuts/123?category=electronics'); // Oops! Typo = runtime error
```

### ✅ After: Zero-Ambiguity Magic
```dart
// 🎯 Your constructor IS your route config
class ProductPage extends StatelessWidget {
  final String productId;    // Auto-becomes /products/:productId  
  final String? category;    // Auto-becomes ?category=value
  final int? page;          // Auto-parsed from ?page=1
  
  const ProductPage({
    super.key,
    required this.productId,  // Required = Path parameter
    this.category,            // Optional = Query parameter  
    this.page,               // Nullable = Optional query
  });
}

// 🎯 100% type-safe navigation
Navigate.goToProduct(
  productId: '123',         // ✅ Required parameter - impossible to forget!
  category: 'electronics',  // ✅ Optional parameter - perfect IntelliSense
  page: 2,                 // ✅ Type-safe int - no parsing errors
);
```

### 🚀 The Result: 90% Less Code, 100% More Safety

- **5 minutes setup** vs. hours of manual configuration
- **Zero boilerplate** - your file system is your route map
- **Type-safe navigation** - impossible to make typo errors
- **Smart parameter detection** - constructor parameters become route parameters
- **Zero-config guards** - simple interfaces for route protection
- **Instant app creation** - complete apps generated in seconds

---

## 🚀 Quick Start

### 1. Instant App Creation (Recommended)

Create a complete Flutter app with routing in seconds:

```bash
# Create app with instant routing setup
dart run go_router_sugar new my_app --template minimal
cd my_app && flutter run
```

**Available templates:**
- `minimal` - Clean starter with navigation setup

### 🧹 Clean & Unified Architecture (v1.2.1)

Go Router Sugar now features a **completely unified architecture** with zero ambiguities:

- ✅ **Single Source of Truth** - No duplicate classes or conflicting implementations
- ✅ **Comprehensive Help System** - Every command supports `--help` with beautiful output
- ✅ **Smart Guards Unified** - Single, powerful guard system with @Protected annotations
- ✅ **Clean CLI Structure** - Consistent command interface across all operations
- ✅ **Zero Conflicts** - All architectural duplications eliminated

```bash
# Get help for any command
dart run go_router_sugar --help
dart run go_router_sugar generate --help
dart run go_router_sugar watch --help
dart run go_router_sugar visual --help
dart run go_router_sugar new --help
```

---

**Choose your instant app:**

- `minimal` - Clean starter with navigation
- `ecommerce` - Products, cart, checkout, profile  
- `auth` - Complete authentication flow

---

## ✨ All Features at a Glance

**Core Zero-Ambiguity Features:**

- ⚡ **Instant App Creation** - Complete Flutter apps in seconds with templates
- 🧠 **Smart Parameter Detection** - Constructor parameters become route parameters automatically  
- 🛡️ **Zero-Config Route Guards** - Simple interface implementation for authentication
- 📁 **File-Based Routing** - Your file system becomes your route map
- 🔒 **100% Type Safety** - Impossible to make navigation typos
- 🎨 **Beautiful Transitions** - Professional animations with one line

**Advanced Capabilities:**

- 🚀 **Zero Boilerplate** - Automatically generates `GoRouter` configuration
- ⚡ **Dynamic Routes** - Built-in support for path parameters using `[param]` syntax
- 🎯 **Flutter-First** - Designed specifically for Flutter's ecosystem
- 📱 **Hot Reload Friendly** - Works seamlessly with Flutter's development workflow
- 🔧 **Progressive Enhancement** - Simple start, powerful when needed

---

## 📖 Documentation

### 2. Manual Setup (For Existing Projects)

**Add dependencies:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^16.1.0

dev_dependencies:
  build_runner: ^2.4.9
  go_router_sugar: ^1.1.0
```
  flutter:
    sdk: flutter
  go_router: ^16.1.0

dev_dependencies:
  build_runner: ^2.4.9
  go_router_sugar: ^1.0.0
```

### 5. Create Your Pages

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

**Page with smart parameters** (`lib/pages/products/[id]_page.dart`):

```dart
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String id;          // ✅ Auto-injected from route path
  final String? category;   // ✅ Auto-injected from query params
  final int? page;         // ✅ Auto-parsed to correct type

  const ProductPage({
    super.key, 
    required this.id,
    this.category,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $id')),
      body: Center(
        child: Column(
          children: [
            Text('Product ID: $id'),
            if (category != null) Text('Category: $category'),
            if (page != null) Text('Page: $page'),
          ],
        ),
      ),
    );
  }
}
```

### 6. Generate Your Routes

Run the code generator to create your `app_router.g.dart` file.

**🌟 Option 1: Use the Smart CLI (Recommended)**

```bash
# Generate routes for existing project
dart run go_router_sugar generate

# Watch for file changes (perfect for development)  
dart run go_router_sugar watch

# Visualize your route tree
dart run go_router_sugar visual

# Get help for any command
dart run go_router_sugar generate --help
```

**⚙️ Option 2: Use the Standard Dart Build Runner**

```bash
# Run the generator once
dart run build_runner build --delete-conflicting-outputs

# Watch for file changes
dart run build_runner watch --delete-conflicting-outputs
```

### 7. Use the Generated Router

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

### 8. Navigate with Type-Safety

Forget string-based paths and runtime errors. Use the generated, type-safe navigation helpers for 100% safety and IDE autocomplete.

```dart
import 'package:flutter/material.dart';
import 'app_router.g.dart'; // Import the generated file

// Option 1: Static Navigate class (simple and direct)
Navigate.goToHome();
Navigate.goToProduct(id: 'abc-123', category: 'electronics', page: 2);

// Option 2: GoRouter/BuildContext extension methods (fluent and idiomatic)
context.goToHome();
context.goToProduct(id: 'abc-123', category: 'electronics', page: 2);
```

While you *can* still use raw strings with the generated `Routes` constants (`context.go(Routes.home)`), the navigation helpers are the recommended, safer approach.

-----

## ✨ Features

  - 🚀 **Zero Boilerplate**: Automatically generates `GoRouter` configuration.
  - 📁 **File-Based Routing**: Your file system becomes your route map.
  - � **Smart Parameter Detection**: Constructor parameters become route/query parameters automatically.
  - 🛡️ **Zero-Config Route Guards**: Simple interface implementation for authentication.
  - �🎨 **Rich Page Transitions**: 15+ built-in transition types with zero effort.
  - 🔧 **Instant App Creation**: Complete apps with `dart run go_router_sugar new my_app`.
  - � **Progressive Enhancement**: Simple start, powerful when needed.
  - ⚡ **Dynamic Routes**: Built-in support for path parameters using `[param]` syntax.
  - 🎯 **Flutter-First**: Designed specifically for Flutter's ecosystem.
  - 📱 **Hot Reload Friendly**: Works seamlessly with Flutter's development workflow.
  - 🎭 **Per-Page Transitions**: Configure transitions individually for each page.
  - 🗂️ **Shell Routes**: Automatic layout detection for nested navigation.
  - 📊 **Query Parameters**: Type-safe query parameter handling with automatic parsing.
  - 📈 **Analytics**: Built-in route analytics and performance monitoring.
  - 🛠️ **Smart CLI**: Template-based app creation and intelligent generation.
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