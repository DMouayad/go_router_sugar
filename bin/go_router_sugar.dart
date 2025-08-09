#!/usr/bin/env dart
// ignore_for_file: avoid_catches_without_on_clauses, prefer_const_constructors, prefer_const_declarations, invalid_assignment, inference_failure_on_instance_creation

import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

/// 🍬 Go Router Sugar - The Simplest Flutter Routing Ever!
///
/// Commands so easy, even kids can use them:
/// • generate - Interactive setup wizard
/// • watch - Auto-magic route generation
/// • visual - Beautiful route visualization
/// • new - Create instant Flutter apps
void main(List<String> arguments) async {
  print('');
  print('🍬 Go Router Sugar - The Simplest Flutter Routing Ever!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');

  if (arguments.isEmpty) {
    _showMainMenu();
    return;
  }

  final command = arguments[0].toLowerCase();

  switch (command) {
    case 'generate':
    case 'gen':
    case 'g':
      await _runGenerate(arguments.skip(1).toList());
      break;

    case 'watch':
    case 'w':
      await _runSmartWatch();
      break;

    case 'visual':
    case 'vis':
    case 'v':
      await _showVisualRoutes();
      break;

    case 'new':
    case 'create':
      await _createNewApp(arguments.skip(1).toList());
      break;

    case 'help':
    case '--help':
    case '-h':
      _showDetailedHelp();
      break;

    default:
      print('❌ Unknown command: $command');
      print('💡 Try: dart run go_router_sugar help');
      exit(1);
  }
}

/// 🎨 Beautiful main menu
void _showMainMenu() {
  print('✨ What would you like to do today?');
  print('');
  print('  📝 generate  →  Interactive setup wizard (asks simple questions)');
  print('  👀 watch     →  Auto-magic route generation (watches for changes)');
  print('  🎨 visual    →  Beautiful route map visualization');
  print('  🚀 new       →  Create instant Flutter app with routing');
  print('  ❓ help      →  Show detailed help');
  print('');
  print('💡 Example: dart run go_router_sugar generate');
  print('');
}

/// 🎯 Run generate command - handles both interactive and command-line modes
Future<void> _runGenerate(List<String> args) async {
  // Parse command-line arguments
  String? pagesPath;
  String? outputPath;
  String? initialRoute;

  for (int i = 0; i < args.length; i++) {
    final arg = args[i];

    // Handle --key=value format
    if (arg.startsWith('--pages-path=')) {
      pagesPath = arg.substring('--pages-path='.length);
    } else if (arg.startsWith('--output-path=')) {
      outputPath = arg.substring('--output-path='.length);
    } else if (arg.startsWith('--initial-route=')) {
      initialRoute = arg.substring('--initial-route='.length);
    }
    // Handle --key value format
    else if (arg == '--pages-path' && i + 1 < args.length) {
      pagesPath = args[i + 1];
    } else if (arg == '--output-path' && i + 1 < args.length) {
      outputPath = args[i + 1];
    } else if (arg == '--initial-route' && i + 1 < args.length) {
      initialRoute = args[i + 1];
    }
  }

  // If any required parameter is missing, run interactive mode
  if (pagesPath == null || outputPath == null || initialRoute == null) {
    await _runInteractiveGenerate();
    return;
  }

  // Run in non-interactive mode
  try {
    print('🎯 Running in non-interactive mode...');
    print('   📁 Pages folder: $pagesPath');
    print('   🏠 Initial route: $initialRoute');
    print('   📄 Output file: $outputPath');
    print('');

    // Generate the routes
    await _generateRoutes(pagesPath, initialRoute, outputPath);

    print('');
    print('✅ Routes generated successfully!');
    print('💡 Run "dart run go_router_sugar watch" for auto-magic updates!');
  } catch (e) {
    print('');
    print('❌ Oops! Something went wrong: $e');
    print(
        '💡 Try running the command again or check your Flutter project setup.');
    exit(1);
  }
}

Future<void> _runInteractiveGenerate() async {
  print('🧙‍♂️ Welcome to the Interactive Setup Wizard!');
  print('   I\'ll ask you 3 simple questions to set up your routes...');
  print('');

  try {
    // Question 1: Pages path
    final pagesPath = await _askPagesPath();

    // Question 2: Initial route
    final initialRoute = await _askInitialRoute();

    // Question 3: Output location
    final outputPath = await _askOutputPath(pagesPath);

    print('');
    print('🎯 Perfect! Here\'s what I found:');
    print('   📁 Pages folder: $pagesPath');
    print('   🏠 Home route: $initialRoute');
    print('   📄 Generated file: $outputPath');
    print('');

    // Generate the routes
    await _generateRoutes(pagesPath, initialRoute, outputPath);

    // Show helpful next steps
    _showHelpfulTips(outputPath);
  } catch (e) {
    print('');
    print('❌ Oops! Something went wrong: $e');
    print(
        '💡 Try running the command again or check your Flutter project setup.');
    exit(1);
  }
}

/// 📁 Ask for pages path with smart defaults
Future<String> _askPagesPath() async {
  print('📁 Question 1: Where are your page files located?');
  print('   Common examples: lib/pages, lib/screens, lib/views');
  print('');

  // Check for common page directories
  final commonPaths = ['lib/pages', 'lib/screens', 'lib/views'];
  final existingPaths =
      commonPaths.where((p) => Directory(p).existsSync()).toList();

  if (existingPaths.isNotEmpty) {
    print('   🔍 I found these page folders in your project:');
    for (int i = 0; i < existingPaths.length; i++) {
      print('   ${i + 1}. ${existingPaths[i]}');
    }
    print('');
  }

  stdout.write('   📝 Pages path (default: lib/pages): ');
  final input = stdin.readLineSync()?.trim() ?? '';

  if (input.isEmpty) {
    const defaultPath = 'lib/pages';
    if (!Directory(defaultPath).existsSync()) {
      print('   📁 Creating $defaultPath folder for you...');
      Directory(defaultPath).createSync(recursive: true);
    }
    return defaultPath;
  }

  if (!Directory(input).existsSync()) {
    print('   📁 Creating $input folder for you...');
    Directory(input).createSync(recursive: true);
  }

  return input;
}

/// 🏠 Ask for initial route
Future<String> _askInitialRoute() async {
  print('');
  print('🏠 Question 2: What should be your app\'s starting page?');
  print('   This is the first page users see when they open your app.');
  print('   Common examples: /, /home, /splash, /welcome');
  print('');
  stdout.write('   📝 Initial route (default: /): ');
  final input = stdin.readLineSync()?.trim() ?? '';

  if (input.isEmpty) return '/';
  if (!input.startsWith('/')) return '/$input';
  return input;
}

/// 📄 Ask for output path
Future<String> _askOutputPath(String pagesPath) async {
  print('');
  print('📄 Question 3: Where should I save the generated routes file?');
  print('   This file will contain all your auto-generated routing code.');
  print('');

  final defaultOutput = path.join(pagesPath, 'app_router.g.dart');
  stdout.write('   📝 Output file (default: $defaultOutput): ');
  final input = stdin.readLineSync()?.trim() ?? '';

  return input.isEmpty ? defaultOutput : input;
}

/// 🎯 Generate routes with beautiful progress
Future<void> _generateRoutes(
    String pagesPath, String initialRoute, String outputPath) async {
  print('🎯 Generating your routes...');
  print('');

  // Scan for page files
  final pageFiles = await _scanPageFiles(pagesPath);

  if (pageFiles.isEmpty) {
    print('⚠️  No page files found in $pagesPath');
    print(
        '💡 Create a page file like: ${path.join(pagesPath, 'home_page.dart')}');
    print('');
    print('Example page file:');
    print('''
```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Welcome Home! 🏠'),
      ),
    );
  }
}
```
    ''');
    return;
  }

  print('✅ Found ${pageFiles.length} page files:');
  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    print('   📄 ${path.basename(file)} → $route');
  }
  print('');

  // Generate the router file
  final routerContent =
      _generateRouterContent(pageFiles, pagesPath, initialRoute);

  // Write to file
  final outputFile = File(outputPath);
  await outputFile.create(recursive: true);
  await outputFile.writeAsString(routerContent);

  print('🎉 Routes generated successfully!');
  print('   📄 File saved: $outputPath');
  print('');
}

/// 👀 Smart watch mode - Auto-magic route generation
Future<void> _runSmartWatch() async {
  print('👀 Smart Watch Mode - Auto-Magic Route Generation!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');

  // First, check if we have a previous config
  final configFile = File('.go_router_sugar_config.json');
  Map<String, dynamic> config = {};

  if (configFile.existsSync()) {
    try {
      config = jsonDecode(await configFile.readAsString());
      print('📋 Using previous configuration:');
      print('   📁 Pages: ${config['pagesPath']}');
      print('   🏠 Initial: ${config['initialRoute']}');
      print('   📄 Output: ${config['outputPath']}');
      print('');
    } catch (e) {
      print(
          '⚠️  Previous config found but couldn\'t read it. Setting up fresh...');
      print('');
    }
  }

  // If no config, ask for setup
  if (config.isEmpty) {
    print('🔧 No previous setup found. Let\'s do a quick setup first...');
    print('');

    final pagesPath = await _askPagesPath();
    final initialRoute = await _askInitialRoute();
    final outputPath = await _askOutputPath(pagesPath);

    config = {
      'pagesPath': pagesPath,
      'initialRoute': initialRoute,
      'outputPath': outputPath,
    };

    // Save config for next time
    await configFile.writeAsString(jsonEncode(config));
    print('');
    print('💾 Configuration saved for future watch sessions!');
    print('');
  }

  final pagesPath = config['pagesPath'] as String;
  final initialRoute = config['initialRoute'] as String;
  final outputPath = config['outputPath'] as String;

  // Generate initial routes
  await _generateRoutes(pagesPath, initialRoute, outputPath);

  print('👀 Now watching for changes... (Press Ctrl+C to stop)');
  print('');
  print('💡 Watch Tips:');
  print('   • Create new page files in $pagesPath');
  print('   • Save or hot reload to see changes');
  print('   • Routes auto-update instantly!');
  print('');

  // Start watching
  final watcher = Directory(pagesPath).watch(recursive: true);

  await for (final event in watcher) {
    if (event.path.endsWith('_page.dart')) {
      final eventType = event.type == FileSystemEvent.create
          ? 'Created'
          : event.type == FileSystemEvent.delete
              ? 'Deleted'
              : event.type == FileSystemEvent.modify
                  ? 'Modified'
                  : 'Changed';

      print('📝 $eventType: ${path.basename(event.path)}');

      // Small delay to let file system settle
      await Future.delayed(Duration(milliseconds: 100));

      try {
        await _generateRoutes(pagesPath, initialRoute, outputPath);
        print('✅ Routes updated! Hot reload to see changes.');
        print('');
      } catch (e) {
        print('❌ Error updating routes: $e');
        print('');
      }
    }
  }
}

/// 🎨 Visual route map - Beautiful console visualization
Future<void> _showVisualRoutes() async {
  print('🎨 Visual Route Map - Beautiful Route Visualization!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');

  // Check for config
  final configFile = File('.go_router_sugar_config.json');
  String pagesPath = 'lib/pages';

  if (configFile.existsSync()) {
    try {
      final config = jsonDecode(await configFile.readAsString());
      pagesPath = config['pagesPath'] ?? 'lib/pages';
    } catch (e) {
      // Use default
    }
  }

  if (!Directory(pagesPath).existsSync()) {
    print('❌ Pages directory not found: $pagesPath');
    print(
        '💡 Run "dart run go_router_sugar generate" first to set up your project.');
    return;
  }

  final pageFiles = await _scanPageFiles(pagesPath);

  if (pageFiles.isEmpty) {
    print('📭 No page files found in $pagesPath');
    print('💡 Create some page files ending with "_page.dart" first!');
    return;
  }

  print('🗺️  Your Route Map:');
  print('');

  // Generate visual tree
  final routes = <String, List<String>>{};
  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final segments = route.split('/').where((s) => s.isNotEmpty).toList();

    String currentPath = '';
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final parentPath = currentPath;
      currentPath = currentPath.isEmpty ? '/$segment' : '$currentPath/$segment';

      routes[parentPath] ??= [];
      if (!routes[parentPath]!.contains(currentPath)) {
        routes[parentPath]!.add(currentPath);
      }
    }
  }

  // Print tree
  _printRouteTree('', routes, '', true);
  print('');

  // Ask if user wants to generate markdown
  print(
      '📄 Would you like to generate a beautiful markdown file with this route map?');
  stdout.write('   📝 Generate routes.md? (y/N): ');
  final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';

  if (input == 'y' || input == 'yes') {
    await _generateRouteMarkdown(pageFiles, pagesPath);
  }
}

/// 🌳 Print beautiful route tree
void _printRouteTree(
    String path, Map<String, List<String>> routes, String prefix, bool isLast) {
  final displayPath = path.isEmpty ? '🏠 /' : path;
  print('$prefix${isLast ? '└── ' : '├── '}$displayPath');

  final children = routes[path] ?? [];
  for (int i = 0; i < children.length; i++) {
    final child = children[i];
    final isLastChild = i == children.length - 1;
    final newPrefix = prefix + (isLast ? '    ' : '│   ');
    _printRouteTree(child, routes, newPrefix, isLastChild);
  }
}

/// 📄 Generate beautiful markdown route documentation
Future<void> _generateRouteMarkdown(
    List<String> pageFiles, String pagesPath) async {
  final buffer = StringBuffer();

  buffer.writeln('# 🗺️ Route Map');
  buffer.writeln('');
  buffer.writeln('> Auto-generated route documentation by Go Router Sugar');
  buffer.writeln('');
  buffer.writeln('## 📋 All Routes');
  buffer.writeln('');
  buffer.writeln('| Route | File | Description |');
  buffer.writeln('|-------|------|-------------|');

  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final relativePath = path.relative(file);
    final className = _extractClassName(file);

    buffer.writeln('| `$route` | `$relativePath` | $className |');
  }

  buffer.writeln('');
  buffer.writeln('## 🌳 Route Tree');
  buffer.writeln('');
  buffer.writeln('```');

  // Generate tree for markdown
  final routes = <String, List<String>>{};
  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final segments = route.split('/').where((s) => s.isNotEmpty).toList();

    String currentPath = '';
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final parentPath = currentPath;
      currentPath = currentPath.isEmpty ? '/$segment' : '$currentPath/$segment';

      routes[parentPath] ??= [];
      if (!routes[parentPath]!.contains(currentPath)) {
        routes[parentPath]!.add(currentPath);
      }
    }
  }

  buffer.writeln('🏠 /');
  _printRouteTreeMarkdown('', routes, '', true, buffer);
  buffer.writeln('```');

  buffer.writeln('');
  buffer.writeln('## 🚀 Usage');
  buffer.writeln('');
  buffer.writeln('```dart');
  buffer.writeln('// Navigate to any route with type safety:');

  for (final file in pageFiles.take(3)) {
    final route = _fileToRoute(file, pagesPath);
    final methodName = _routeToMethodName(route);
    buffer.writeln('Navigate.$methodName();');
  }

  if (pageFiles.length > 3) {
    buffer.writeln('// ... and ${pageFiles.length - 3} more routes!');
  }

  buffer.writeln('```');
  buffer.writeln('');
  buffer.writeln('---');
  buffer.writeln(
      '*Generated on ${DateTime.now().toString().split('.')[0]} by [Go Router Sugar](https://pub.dev/packages/go_router_sugar)*');

  // Write file
  const markdownPath = 'routes.md';
  await File(markdownPath).writeAsString(buffer.toString());

  print('');
  print('🎉 Beautiful route documentation generated!');
  print('   📄 File saved: $markdownPath');
  print('   💡 Open it in VS Code for beautiful formatting!');
  print('');
}

/// 🌳 Print route tree for markdown
void _printRouteTreeMarkdown(String path, Map<String, List<String>> routes,
    String prefix, bool isLast, StringBuffer buffer) {
  if (path.isNotEmpty) {
    buffer.writeln('$prefix${isLast ? '└── ' : '├── '}$path');
  }

  final children = routes[path] ?? [];
  for (int i = 0; i < children.length; i++) {
    final child = children[i];
    final isLastChild = i == children.length - 1;
    final newPrefix = prefix + (isLast && path.isNotEmpty ? '    ' : '│   ');
    _printRouteTreeMarkdown(child, routes, newPrefix, isLastChild, buffer);
  }
}

/// 💡 Show helpful tips after generation
void _showHelpfulTips(String outputPath) {
  print('💡 What\'s Next? Here are your super simple next steps:');
  print('');
  print('  1️⃣  Add this to your main.dart:');
  print('      ```dart');
  print('      import \'${outputPath.replaceAll('\\', '/')}\';');
  print('      ');
  print('      MaterialApp.router(');
  print('        routerConfig: AppRouter.router,');
  print('      )');
  print('      ```');
  print('');
  print('  2️⃣  Start creating pages in your pages folder!');
  print('');
  print('  3️⃣  Use watch mode for auto-magic updates:');
  print('      ```bash');
  print('      dart run go_router_sugar watch');
  print('      ```');
  print('');
  print('  4️⃣  See your beautiful route map:');
  print('      ```bash');
  print('      dart run go_router_sugar visual');
  print('      ```');
  print('');
  print('🎉 That\'s it! You\'re ready to build amazing Flutter apps!');
  print('');
}

/// 🚀 Create new app (simplified version)
Future<void> _createNewApp(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Please provide an app name');
    print('💡 Example: dart run go_router_sugar new my_app');
    return;
  }

  final appName = args[0];
  print('🚀 Creating instant Flutter app: $appName');
  print('   This might take a moment...');

  // Create basic Flutter app structure
  try {
    final result = await Process.run('flutter', ['create', appName]);
    if (result.exitCode != 0) {
      print('❌ Failed to create Flutter app: ${result.stderr}');
      return;
    }

    print('✅ Flutter app created!');
    print('📁 Setting up routing...');

    // Create pages directory and basic pages
    final pagesDir = Directory(path.join(appName, 'lib', 'pages'));
    await pagesDir.create(recursive: true);

    // Create home page
    final homePageContent = '''
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home! 🏠'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🎉 Your Go Router Sugar app is ready!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Start creating pages in lib/pages/',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
''';

    await File(path.join(pagesDir.path, 'home_page.dart'))
        .writeAsString(homePageContent);

    // Generate routes
    final outputPath = path.join(pagesDir.path, 'app_router.g.dart');
    await _generateRoutes(pagesDir.path, '/', outputPath);

    print('✅ Routing setup complete!');
    print('');
    print('🎯 Your new app is ready! Next steps:');
    print('  1️⃣  cd $appName');
    print('  2️⃣  flutter run');
    print('');
    print(
        '💡 Pro tip: Use "dart run go_router_sugar watch" for auto-magic route updates!');
  } catch (e) {
    print('❌ Error creating app: $e');
  }
}

/// 📖 Show detailed help
void _showDetailedHelp() {
  print('🍬 Go Router Sugar - The Simplest Flutter Routing Ever!');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');
  print('🎯 Commands (so easy, even kids can use them!):');
  print('');
  print('  📝 generate (g)   Interactive setup wizard');
  print('                    Asks 3 simple questions and sets up everything');
  print('');
  print('  👀 watch (w)      Auto-magic route generation');
  print(
      '                    Watches your pages folder and updates routes instantly');
  print('');
  print('  🎨 visual (v)     Beautiful route visualization');
  print(
      '                    Shows your route map in the console + generates markdown');
  print('');
  print('  🚀 new           Create instant Flutter app with routing');
  print('                    Creates a complete Flutter app ready to use');
  print('');
  print('💡 Examples:');
  print('  dart run go_router_sugar generate    # Interactive setup');
  print('  dart run go_router_sugar watch       # Auto-magic updates');
  print('  dart run go_router_sugar visual      # Beautiful route map');
  print('  dart run go_router_sugar new my_app  # New Flutter app');
  print('');
  print('🎭 Page File Rules (super simple!):');
  print('  • Files must end with "_page.dart"');
  print('  • File name becomes the route');
  print('  • Use [param] for dynamic routes');
  print('');
  print('📁 Examples:');
  print('  home_page.dart                    → /home');
  print('  products/list_page.dart           → /products/list');
  print('  products/[id]_page.dart           → /products/:id');
  print('  user/profile/settings_page.dart   → /user/profile/settings');
  print('');
}

// Helper functions

/// 📂 Scan for page files
Future<List<String>> _scanPageFiles(String pagesPath) async {
  final pageFiles = <String>[];
  final dir = Directory(pagesPath);

  if (!dir.existsSync()) return pageFiles;

  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('_page.dart')) {
      pageFiles.add(entity.path);
    }
  }

  pageFiles.sort();
  return pageFiles;
}

/// 🛣️ Convert file path to route
String _fileToRoute(String filePath, String pagesPath) {
  final relativePath = path.relative(filePath, from: pagesPath);
  final routePart = relativePath
      .replaceAll('\\', '/')
      .replaceAll('_page.dart', '')
      .replaceAllMapped(
          RegExp(r'\[([^\]]+)\]'), (match) => ':${match.group(1)}');

  return routePart.isEmpty ? '/' : '/$routePart';
}

/// 🏗️ Generate router content with crystal-clear documentation
String _generateRouterContent(
    List<String> pageFiles, String pagesPath, String initialRoute) {
  final buffer = StringBuffer();

  // Header with clear explanation
  buffer.writeln('// 🍬 GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln(
      '// Generated by Go Router Sugar - The Simplest Flutter Routing Ever!');
  buffer.writeln(
      '// 💡 This file is auto-generated. To add new routes, just create new page files!');
  buffer.writeln('//');
  buffer.writeln('// 📖 How to use:');
  buffer.writeln(
      '// 1. Add to your main.dart: MaterialApp.router(routerConfig: AppRouter.router)');
  buffer.writeln('// 2. Navigate anywhere: Navigate.goToHome(context)');
  buffer.writeln(
      '// 3. Add new pages in your pages folder - routes auto-update!');
  buffer.writeln('');
  buffer.writeln('import \'package:flutter/material.dart\';');
  buffer.writeln('import \'package:go_router/go_router.dart\';');
  buffer.writeln('');

  // Import page files with explanation
  buffer.writeln('// 📄 Your page imports (auto-generated)');
  for (final file in pageFiles) {
    final relativePath = path.relative(file, from: path.dirname(pagesPath));
    final className = _extractClassName(file);
    buffer.writeln(
        'import \'${relativePath.replaceAll('\\', '/')}\'; // → $className');
  }
  buffer.writeln('');

  // Route constants with clear names and documentation
  buffer
      .writeln('/// 🗺️ Route constants - Use these instead of magic strings!');
  buffer.writeln('/// ');
  buffer.writeln(
      '/// Example: context.go(Routes.home) instead of context.go(\'/home\')');
  buffer.writeln('class Routes {');
  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final constantName = _routeToConstantName(route);
    final description = _getRouteDescription(route, file);

    buffer.writeln('  /// $description');
    buffer.writeln('  static const String $constantName = \'$route\';');
    buffer.writeln('');
  }
  buffer.writeln('}');
  buffer.writeln('');

  // Router class with documentation
  buffer.writeln(
      '/// 🚀 Main router configuration - Your app\'s navigation brain!');
  buffer.writeln('/// ');
  buffer.writeln(
      '/// Use in main.dart: MaterialApp.router(routerConfig: AppRouter.router)');
  buffer.writeln('class AppRouter {');
  buffer.writeln(
      '  /// The configured GoRouter instance - handles all your app navigation');
  buffer.writeln('  static final GoRouter router = GoRouter(');
  buffer.writeln('    initialLocation: \'$initialRoute\', // 🏠 Starting page');
  buffer.writeln('    routes: [');

  // Generate routes with clear documentation
  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final className = _extractClassName(file);
    final description = _getRouteDescription(route, file);

    buffer.writeln('      // $description');
    buffer.writeln('      GoRoute(');
    buffer.writeln('        path: \'$route\',');
    buffer.writeln('        builder: (context, state) => const $className(),');
    buffer.writeln('      ),');
    buffer.writeln('');
  }

  buffer.writeln('    ],');
  buffer.writeln('  );');
  buffer.writeln('}');
  buffer.writeln('');

  // Navigation helpers with clear documentation and examples
  buffer.writeln('/// 🧭 Navigation helpers - Type-safe navigation made easy!');
  buffer.writeln('/// ');
  buffer
      .writeln('/// Instead of: context.go(\'/products/123\') ❌ (typo-prone)');
  buffer.writeln(
      '/// Use this:   Navigate.goToProductDetail(context) ✅ (type-safe)');
  buffer.writeln('class Navigate {');

  for (final file in pageFiles) {
    final route = _fileToRoute(file, pagesPath);
    final methodName = _routeToMethodName(route);
    final description = _getRouteDescription(route, file);
    final hasParams = route.contains(':');

    buffer.writeln('  /// Navigate to: $description');
    if (hasParams) {
      buffer.writeln(
          '  /// Note: This route needs parameters - implement parameter passing!');
    }
    buffer.writeln('  /// Example: Navigate.$methodName(context);');

    if (hasParams) {
      // For dynamic routes, show parameter guidance
      final params = _extractRouteParams(route);
      buffer.writeln('  static void $methodName(BuildContext context, {');
      for (final param in params) {
        buffer.writeln(
            '    required String $param, // 📝 Pass the $param value here');
      }
      buffer.writeln('  }) {');
      buffer.write('    context.go(\'$route\'');
      for (final param in params) {
        buffer.write('.replaceAll(\':$param\', $param)');
      }
      buffer.writeln(');');
    } else {
      buffer.writeln('  static void $methodName(BuildContext context) {');
      buffer.writeln('    context.go(\'$route\');');
    }
    buffer.writeln('  }');
    buffer.writeln('');
  }

  buffer.writeln('  /// 💡 Quick tip: Add more pages to your pages folder');
  buffer.writeln(
      '  /// and run "dart run go_router_sugar watch" for auto-updates!');
  buffer.writeln('}');

  return buffer.toString();
}

/// 📝 Extract class name from file
String _extractClassName(String filePath) {
  try {
    // Try to read the actual file and extract the class name
    final fileContent = File(filePath).readAsStringSync();
    final classMatch = RegExp(r'class\s+(\w+)\s+extends\s+StatelessWidget')
        .firstMatch(fileContent);
    if (classMatch != null) {
      return classMatch.group(1)!;
    }

    // Fallback to StatefulWidget
    final statefulMatch = RegExp(r'class\s+(\w+)\s+extends\s+StatefulWidget')
        .firstMatch(fileContent);
    if (statefulMatch != null) {
      return statefulMatch.group(1)!;
    }
  } catch (e) {
    // If file reading fails, fall back to naming convention
  }

  // Fallback: generate class name from file name
  final fileName = path.basename(filePath);
  final baseName = fileName.replaceAll('_page.dart', '');

  // Handle dynamic parameters smartly
  String cleanBaseName = baseName.replaceAll(RegExp(r'\[[^\]]+\]'), '');
  if (cleanBaseName.isEmpty) {
    // If only brackets remain, use a default name
    cleanBaseName = 'dynamic';
  }

  final parts =
      cleanBaseName.split('_').where((part) => part.isNotEmpty).map((part) {
    return part.isNotEmpty ? part[0].toUpperCase() + part.substring(1) : '';
  }).toList();

  if (parts.isEmpty) {
    return 'DynamicPage';
  }

  return '${parts.join('')}Page';
}

/// 🔀 Convert route to method name
String _routeToMethodName(String route) {
  if (route == '/') return 'goToHome';

  final cleanRoute = route.startsWith('/') ? route.substring(1) : route;
  final parts = cleanRoute
      .split('/')
      .map((part) {
        if (part.startsWith(':')) {
          return part.substring(1).replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
        }
        return part.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      })
      .where((part) => part.isNotEmpty)
      .toList();

  if (parts.isEmpty) return 'goToHome';

  final methodParts = parts.map((part) {
    return part.isNotEmpty ? part[0].toUpperCase() + part.substring(1) : '';
  }).toList();

  return 'goTo${methodParts.join('')}';
}

/// 🏷️ Convert route to constant name
String _routeToConstantName(String route) {
  if (route == '/') return 'home';

  final cleanRoute = route.startsWith('/') ? route.substring(1) : route;

  // Convert dynamic parameters more intelligently
  final cleanName = cleanRoute
      .replaceAll(RegExp(r':(\w+)'), r'_$1') // :id becomes _id
      .replaceAll('/', '_') // slashes become underscores
      .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), ''); // remove other special chars

  return cleanName.isEmpty ? 'home' : cleanName;
}

/// 📖 Get human-readable description for a route
String _getRouteDescription(String route, String filePath) {
  final fileName = path.basename(filePath).replaceAll('_page.dart', '');

  if (route == '/') return '🏠 Home page - Your app\'s starting point';

  final hasParams = route.contains(':');

  if (hasParams) {
    final params = _extractRouteParams(route);
    final paramDesc = params.map((p) => 'specific $p').join(' and ');
    return '🔍 ${_capitalizeWords(fileName)} page for $paramDesc';
  }

  return '📄 ${_capitalizeWords(fileName)} page';
}

/// 🔍 Extract parameter names from route
List<String> _extractRouteParams(String route) {
  final regex = RegExp(r':(\w+)');
  final matches = regex.allMatches(route);
  return matches.map((match) => match.group(1)!).toList();
}

/// ✨ Capitalize words for descriptions
String _capitalizeWords(String text) {
  return text.split('_').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
