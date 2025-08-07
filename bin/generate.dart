#!/usr/bin/env dart

import 'dart:io';

/// Simple executable to generate routes without build_runner
Future<void> main(List<String> args) async {
  // Handle help flag
  if (args.contains('--help') || args.contains('-h')) {
    _printHelp();
    return;
  }

  // Handle version flag
  if (args.contains('--version') || args.contains('-v')) {
    print('go_router_sugar v1.0.0');
    return;
  }

  // Parse custom pages directory
  String pagesDirectory = 'lib/pages';
  final dirIndex = args.indexOf('--pages-dir');
  if (dirIndex != -1 && dirIndex < args.length - 1) {
    pagesDirectory = args[dirIndex + 1];
  } else {
    final shortDirIndex = args.indexOf('-d');
    if (shortDirIndex != -1 && shortDirIndex < args.length - 1) {
      pagesDirectory = args[shortDirIndex + 1];
    }
  }

  // Parse custom output file
  String outputFile = 'lib/app_router.g.dart';
  final outIndex = args.indexOf('--output');
  if (outIndex != -1 && outIndex < args.length - 1) {
    outputFile = args[outIndex + 1];
  } else {
    final shortOutIndex = args.indexOf('-o');
    if (shortOutIndex != -1 && shortOutIndex < args.length - 1) {
      outputFile = args[shortOutIndex + 1];
    }
  }

  print('🚀 Generating go_router_sugar routes...');
  print('📁 Pages directory: $pagesDirectory');
  print('📄 Output file: $outputFile');

  try {
    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      print(
          '❌ Error: No pubspec.yaml found. Run this from your Flutter project root.');
      exit(1);
    }

    // Check if pages directory exists
    if (!Directory(pagesDirectory).existsSync()) {
      print('❌ Error: Pages directory "$pagesDirectory" does not exist.');
      print(
          '💡 Create the directory or specify a different one with --pages-dir');
      exit(1);
    }

    // Create custom build.yaml if using non-default settings
    if (pagesDirectory != 'lib/pages' ||
        outputFile != 'lib/app_router.g.dart') {
      await _createCustomBuildConfig(pagesDirectory, outputFile);
    }

    // Run the code generation
    final result = await Process.run('dart', ['run', 'build_runner', 'build']);

    if (result.exitCode == 0) {
      print('✅ Routes generated successfully!');
      print('Generated file: $outputFile');
      print('');
      print('💡 Next steps:');
      print('   • Import: import \'${outputFile.replaceAll('lib/', '')}\';');
      print('   • Use: MaterialApp.router(routerConfig: AppRouter.router)');
      print('   • Navigate: Navigate.goToYourPage();');
    } else {
      print('❌ Error generating routes:');
      print(result.stderr);
      exit(1);
    }
  } on Exception catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

/// Creates a custom build.yaml configuration for non-default settings
Future<void> _createCustomBuildConfig(
    String pagesDirectory, String outputFile) async {
  final buildConfig = '''
# Auto-generated build configuration for go_router_sugar
targets:
  \$default:
    builders:
      go_router_sugar:routes:
        enabled: true
        options:
          pages_directory: "$pagesDirectory"
          output_file: "$outputFile"
''';

  await File('build.yaml').writeAsString(buildConfig);
  print('📝 Created custom build.yaml configuration');
}

void _printHelp() {
  print('''
🚀 go_router_sugar - Zero-effort file-based routing

USAGE:
   go_router_sugar [OPTIONS]

OPTIONS:
   -d, --pages-dir <DIR>     Directory containing page files (default: lib/pages)
   -o, --output <FILE>       Output file for generated code (default: lib/app_router.g.dart)
   -h, --help                Show this help message
   -v, --version             Show version information

EXAMPLES:
   go_router_sugar                                    # Use default lib/pages
   go_router_sugar --pages-dir lib/screens            # Custom pages directory
   go_router_sugar -d lib/views -o lib/router.g.dart  # Custom directory and output
   go_router_sugar_watch --watch                      # Watch for changes

COMMON DIRECTORY PATTERNS:
   lib/pages/         # Default (recommended)
   lib/screens/       # Alternative naming
   lib/views/         # MVC pattern
   lib/ui/pages/      # Nested structure
   src/pages/         # Some prefer src over lib

For more information, visit: https://pub.dev/packages/go_router_sugar
''');
}
