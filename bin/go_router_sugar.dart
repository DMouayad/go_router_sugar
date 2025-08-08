#!/usr/bin/env dart

import 'dart:io';
import 'package:path/path.dart' as path;

/// Enhanced CLI for zero-effort Flutter app creation and route generation
Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _printHelp();
    return;
  }

  final command = args[0];

  switch (command) {
    case 'new':
    case 'create':
      await _createNewApp(args.skip(1).toList());
      break;
    case 'generate':
    case 'gen':
      await _generateRoutes(args.skip(1).toList());
      break;
    case 'templates':
    case 'list':
      _listTemplates();
      break;
    case 'help':
    case '--help':
    case '-h':
      _printHelp();
      break;
    case 'version':
    case '--version':
    case '-v':
      print('go_router_sugar v1.0.0');
      break;
    default:
      print('❌ Unknown command: $command');
      print('💡 Try: dart run go_router_sugar help');
  }
}

/// Create a new Flutter app with routing ready
Future<void> _createNewApp(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Please provide an app name');
    print('💡 Example: dart run go_router_sugar new my_app --template minimal');
    return;
  }

  final appName = args[0];
  String templateName = 'minimal';

  // Parse template flag
  final templateIndex = args.indexOf('--template');
  if (templateIndex != -1 && templateIndex < args.length - 1) {
    templateName = args[templateIndex + 1];
  }

  final template = _getTemplate(templateName);
  if (template == null) {
    print('❌ Unknown template: $templateName');
    print('💡 Available templates: minimal, ecommerce, auth');
    return;
  }

  print('🚀 Creating Flutter app: $appName');
  print('📋 Using template: ${template.name} - ${template.description}');

  try {
    // Create Flutter project
    final createResult = await Process.run('flutter', ['create', appName]);
    if (createResult.exitCode != 0) {
      print('❌ Failed to create Flutter project');
      print(createResult.stderr);
      return;
    }

    final appDir = Directory(appName);

    // Add go_router_sugar to dependencies
    await _updatePubspec(appDir, template);

    // Create main.dart with router setup
    await _createMainFile(appDir);

    // Create page files from template
    for (final page in template.pages) {
      await _createPageFile(appDir, page);
    }

    // Generate routes
    await _runGeneration(appDir);

    print('✅ App created successfully!');
    print('');
    print('🎯 Next steps:');
    print('   cd $appName');
    print('   flutter run');
    print('');
    print('📝 Your app includes:');
    for (final page in template.pages) {
      final routePath = _filePathToRoute(page.filePath);
      print('   • $routePath (${page.filePath})');
    }
  } on Exception catch (e) {
    print('❌ Error creating app: $e');
  }
}

/// Generate routes for existing project
Future<void> _generateRoutes(List<String> args) async {
  // Parse arguments (same as existing generate.dart)
  String pagesDirectory = 'lib/pages';
  final dirIndex = args.indexOf('--pages-dir');
  if (dirIndex != -1 && dirIndex < args.length - 1) {
    pagesDirectory = args[dirIndex + 1];
  }

  print('🚀 Generating go_router_sugar routes...');
  print('📁 Pages directory: $pagesDirectory');

  try {
    await _runGeneration(Directory.current);
    print('✅ Routes generated successfully!');
  } on Exception catch (e) {
    print('❌ Error generating routes: $e');
  }
}

/// Run the route generation
Future<void> _runGeneration(Directory projectDir) async {
  final buildResult = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: projectDir.path,
  );

  if (buildResult.exitCode != 0) {
    throw Exception('Build runner failed: ${buildResult.stderr}');
  }
}

/// Update pubspec.yaml with dependencies
Future<void> _updatePubspec(Directory appDir, AppTemplate template) async {
  final pubspecFile = File(path.join(appDir.path, 'pubspec.yaml'));
  final content = await pubspecFile.readAsString();

  final updatedContent = content.replaceFirst(
    'dependencies:\n  flutter:\n    sdk: flutter',
    'dependencies:\n  flutter:\n    sdk: flutter\n  go_router: ^16.1.0${template.dependencies.isNotEmpty ? '\n${template.dependencies.entries.map((e) => '  ${e.key}: ${e.value}').join('\n')}' : ''}\n\ndev_dependencies:\n  flutter_test:\n    sdk: flutter\n  flutter_lints: ^6.0.0\n  build_runner: ^2.4.9\n  go_router_sugar: ^1.0.0',
  );

  await pubspecFile.writeAsString(updatedContent);
}

/// Create main.dart with router setup
Future<void> _createMainFile(Directory appDir) async {
  final mainFile = File(path.join(appDir.path, 'lib', 'main.dart'));

  const mainContent = '''import 'package:flutter/material.dart';
import 'app_router.g.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: AppRouter.router,
    );
  }
}
''';

  await mainFile.writeAsString(mainContent);
}

/// Create a page file from template
Future<void> _createPageFile(Directory appDir, PageTemplate page) async {
  final filePath = path.join(appDir.path, page.filePath);
  final file = File(filePath);

  // Create directory if it doesn't exist
  await file.parent.create(recursive: true);

  await file.writeAsString(page.content);
}

/// Convert file path to route path for display
String _filePathToRoute(String filePath) {
  return filePath
      .replaceFirst('lib/pages/', '/')
      .replaceFirst('_page.dart', '')
      .replaceAllMapped(RegExp(r'\[(\w+)\]'), (match) => ':${match.group(1)}');
}

/// Get template by name
AppTemplate? _getTemplate(String name) {
  switch (name) {
    case 'minimal':
      return const AppTemplate(
        name: 'minimal',
        description: 'Just home + about pages - perfect for getting started',
        pages: [
          PageTemplate(
            filePath: 'lib/pages/home_page.dart',
            content: _homePageMinimal,
          ),
          PageTemplate(
            filePath: 'lib/pages/about_page.dart',
            content: _aboutPageMinimal,
          ),
        ],
      );
    case 'ecommerce':
      return const AppTemplate(
        name: 'ecommerce',
        description:
            'Products, cart, checkout, profile - complete shopping experience',
        pages: [
          PageTemplate(
            filePath: 'lib/pages/home_page.dart',
            content: _homePageEcommerce,
          ),
          PageTemplate(
            filePath: 'lib/pages/products/list_page.dart',
            content: _productsListPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/products/[productId]_page.dart',
            content: _productDetailPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/cart_page.dart',
            content: _cartPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/profile_page.dart',
            content: _profilePage,
          ),
        ],
        dependencies: {
          'cached_network_image': '^3.3.0',
        },
      );
    case 'auth':
      return const AppTemplate(
        name: 'auth',
        description:
            'Login, signup, forgot password, profile - complete auth flow',
        pages: [
          PageTemplate(
            filePath: 'lib/pages/login_page.dart',
            content: _loginPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/signup_page.dart',
            content: _signupPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/forgot_password_page.dart',
            content: _forgotPasswordPage,
          ),
          PageTemplate(
            filePath: 'lib/pages/profile_page.dart',
            content: _profilePageAuth,
          ),
        ],
      );
    default:
      return null;
  }
}

/// List available templates
void _listTemplates() {
  print('📋 Available Templates:');
  print('');
  print(
      '🏠 minimal    - Just home + about pages (perfect for getting started)');
  print(
      '🛒 ecommerce  - Products, cart, checkout, profile (complete shopping experience)');
  print(
      '🔐 auth       - Login, signup, forgot password, profile (complete auth flow)');
  print('');
  print('💡 Usage: dart run go_router_sugar new my_app --template minimal');
}

/// Print help information
void _printHelp() {
  print('🍬 Go Router Sugar CLI - Zero-effort file-based routing for Flutter');
  print('');
  print('📋 Commands:');
  print('');
  print('🚀 Create New App:');
  print('   dart run go_router_sugar new <app_name> [--template <template>]');
  print('   dart run go_router_sugar create my_app --template ecommerce');
  print('');
  print('⚡ Generate Routes:');
  print('   dart run go_router_sugar generate [--pages-dir <dir>]');
  print('   dart run go_router_sugar gen --pages-dir lib/screens');
  print('');
  print('📋 List Templates:');
  print('   dart run go_router_sugar templates');
  print('   dart run go_router_sugar list');
  print('');
  print('ℹ️  Help & Info:');
  print('   dart run go_router_sugar help');
  print('   dart run go_router_sugar version');
  print('');
  print('🎯 Examples:');
  print('   # Create minimal app');
  print('   dart run go_router_sugar new my_app');
  print('');
  print('   # Create ecommerce app');
  print('   dart run go_router_sugar new shop_app --template ecommerce');
  print('');
  print('   # Generate routes for existing project');
  print('   dart run go_router_sugar generate');
}

/// Template classes and content (simplified for CLI)
class AppTemplate {
  /// Creates an app template.
  const AppTemplate({
    required this.name,
    required this.description,
    required this.pages,
    this.dependencies = const {},
  });

  /// The template name.
  final String name;

  /// The template description.
  final String description;

  /// The page templates included.
  final List<PageTemplate> pages;

  /// Additional dependencies required.
  final Map<String, String> dependencies;
}

class PageTemplate {
  /// Creates a page template.
  const PageTemplate({
    required this.filePath,
    required this.content,
  });

  /// The file path for this template.
  final String filePath;

  /// The file content.
  final String content;
}

// Template contents (shortened for brevity)
const _homePageMinimal = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to your Flutter app!', 
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigate.goToAbout(),
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _aboutPageMinimal = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('About This App', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('Built with go_router_sugar 🍬'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigate.goToHome(),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

// Simplified ecommerce templates (shortened for CLI)
const _homePageEcommerce = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          IconButton(
            onPressed: () => Navigate.goToCart(),
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () => Navigate.goToProfile(),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigate.goToProductsProductId(productId: 'product-\$index'),
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Product \$index'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
''';

const _productsListPage = '''
import 'package:flutter/material.dart';
import '../../app_router.g.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: Text('Product \$index'),
            subtitle: Text('\\\$\${(index + 1) * 10}'),
            onTap: () => Navigate.goToProductsProductId(productId: 'product-\$index'),
          );
        },
      ),
    );
  }
}
''';

const _productDetailPage = '''
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String productId;
  
  const ProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product \$productId')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 16),
            Text('Product \$productId', 
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('This is a detailed description of the product.'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _cartPage = '''
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(child: Text('Your cart is empty')),
    );
  }
}
''';

const _profilePage = '''
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('User Profile')),
    );
  }
}
''';

// Auth templates
const _loginPage = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigate.goToProfile(),
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () => Navigate.goToSignup(),
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () => Navigate.goToForgotPassword(),
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _signupPage = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigate.goToProfile(),
                child: const Text('Sign Up'),
              ),
            ),
            TextButton(
              onPressed: () => Navigate.goToLogin(),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _forgotPasswordPage = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your email to reset password'),
            const SizedBox(height: 24),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reset link sent!')),
                  );
                  Navigate.goToLogin();
                },
                child: const Text('Send Reset Link'),
              ),
            ),
            TextButton(
              onPressed: () => Navigate.goToLogin(),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const _profilePageAuth = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => Navigate.goToLogin(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text('John Doe', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('john.doe@example.com'),
          ],
        ),
      ),
    );
  }
}
''';
