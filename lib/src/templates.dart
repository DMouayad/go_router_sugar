/// Template system for instant app creation
class AppTemplate {
  final String name;
  final String description;
  final List<PageTemplate> pages;
  final Map<String, String> dependencies;

  const AppTemplate({
    required this.name,
    required this.description,
    required this.pages,
    this.dependencies = const {},
  });

  static const minimal = AppTemplate(
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

  static const ecommerce = AppTemplate(
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

  static const auth = AppTemplate(
    name: 'auth',
    description: 'Login, signup, forgot password, profile - complete auth flow',
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

  static const List<AppTemplate> all = [minimal, ecommerce, auth];

  /// Get template by name.
  static AppTemplate? getByName(String name) {
    return all.cast<AppTemplate?>().firstWhere(
          (template) => template?.name == name,
          orElse: () => null,
        );
  }
}

class PageTemplate {
  final String filePath;
  final String content;

  const PageTemplate({
    required this.filePath,
    required this.content,
  });
}

// Template contents
const _homePageMinimal = '''
import 'package:flutter/material.dart';
import '../app_router.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to your Flutter app!',
              style: TextStyle(fontSize: 24),
            ),
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
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'About This App',
              style: TextStyle(fontSize: 24),
            ),
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
            Text(
              'Product \$productId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a detailed description of the product.',
              style: TextStyle(fontSize: 16),
            ),
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
      body: const Center(
        child: Text('Your cart is empty'),
      ),
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
      body: const Center(
        child: Text('User Profile'),
      ),
    );
  }
}
''';

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
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
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
            const TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
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
            const Text(
              'Enter your email to reset password',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
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
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('john.doe@example.com'),
          ],
        ),
      ),
    );
  }
}
''';
