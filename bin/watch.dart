#!/usr/bin/env dart

import 'dart:io';

/// Watch mode generator that automatically regenerates routes when files change
Future<void> main(List<String> args) async {
  // Handle help flag
  if (args.contains('--help') || args.contains('-h')) {
    _printHelp();
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

  final watchMode = args.contains('--watch') || args.contains('-w');

  print('🚀 Go Router Sugar${watchMode ? ' (Watch Mode)' : ''}');
  print('📁 Pages directory: $pagesDirectory');
  print('📄 Output file: $outputFile');

  if (watchMode) {
    print('👀 Watching for file changes...');
    print('💡 Create/modify pages in $pagesDirectory to see auto-generation');
    print('🛑 Press Ctrl+C to stop watching');

    // Create custom build.yaml if using non-default settings
    if (pagesDirectory != 'lib/pages' ||
        outputFile != 'lib/app_router.g.dart') {
      await _createCustomBuildConfig(pagesDirectory, outputFile);
    }

    await _runWatchMode();
  } else {
    print('🔨 Generating routes...');

    // Create custom build.yaml if using non-default settings
    if (pagesDirectory != 'lib/pages' ||
        outputFile != 'lib/app_router.g.dart') {
      await _createCustomBuildConfig(pagesDirectory, outputFile);
    }

    await _generateOnce();
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
🚀 go_router_sugar_watch - Auto-regenerate routes on file changes

USAGE:
   go_router_sugar_watch [OPTIONS]

OPTIONS:
   -w, --watch               Watch for file changes and auto-regenerate
   -d, --pages-dir <DIR>     Directory containing page files (default: lib/pages)
   -o, --output <FILE>       Output file for generated code (default: lib/app_router.g.dart)
   -h, --help                Show this help message

EXAMPLES:
   go_router_sugar_watch --watch                           # Watch default lib/pages
   go_router_sugar_watch -w --pages-dir lib/screens        # Watch custom directory
   go_router_sugar_watch -w -d lib/views -o lib/router.g.dart  # Custom directory and output
   go_router_sugar_watch                                   # One-time generation

WATCH MODE:
   • Automatically detects changes in your pages directory
   • Regenerates routes instantly
   • Perfect for development workflow
   • Press Ctrl+C to stop

COMMON DIRECTORY PATTERNS:
   lib/pages/         # Default (recommended)
   lib/screens/       # Alternative naming
   lib/views/         # MVC pattern
   lib/ui/pages/      # Nested structure

For more information, visit: https://pub.dev/packages/go_router_sugar
''');
}

Future<void> _generateOnce() async {
  try {
    final result = await Process.run('dart', ['run', 'build_runner', 'build']);

    if (result.exitCode == 0) {
      print('✅ Routes generated successfully!');
    } else {
      print('❌ Error: ${result.stderr}');
    }
  } on Exception catch (e) {
    print('❌ Error: $e');
  }
}

Future<void> _runWatchMode() async {
  try {
    final process =
        await Process.start('dart', ['run', 'build_runner', 'watch']);

    // Forward stdout and stderr
    process.stdout.listen((data) => stdout.add(data));
    process.stderr.listen((data) => stderr.add(data));

    // Wait for the process to complete
    await process.exitCode;
  } on Exception catch (e) {
    print('❌ Error: $e');
  }
}
