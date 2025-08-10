/// A data class for a scaffolded page file.
class PageTemplate {
  final String filePath;
  final String content;
  const PageTemplate({required this.filePath, required this.content});
}

/// A collection of [PageTemplate]s to create a starter application.
class AppTemplate {
  final String name;
  final List<PageTemplate> pages;

  const AppTemplate({required this.name, required this.pages});

  /// A minimal template with just a home and about page.
  static const AppTemplate minimal = AppTemplate(
    name: 'minimal',
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

  /// A list of all available templates.
  static List<AppTemplate> get all => const [minimal];

  /// Finds a template by its [name].
  static AppTemplate? getByName(String name) {
    try {
      return all.firstWhere((t) => t.name == name);
    } on StateError {
      // Catches the specific error when no element is found.
      return null;
    }
  }
}

// Template Contents
const String _homePageMinimal = '''
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart'; // Uncomment after running 'flutter pub add go_router'

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to your new app!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // context.go('/about'); // Example navigation
              },
              child: const Text('Go to About Page'),
            ),
          ],
        ),
      ),
    );
  }
}
''';

const String _aboutPageMinimal = '''
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Page')),
      body: const Center(
        child: Text('This is the about page, created by go_router_sugar!'),
      ),
    );
  }
}
''';