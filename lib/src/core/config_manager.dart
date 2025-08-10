import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';

/// A data class representing the CLI configuration.
class Config {
  final String pagesPath;
  final String outputPath;
  final String initialRoute;

  Config({
    required this.pagesPath,
    required this.outputPath,
    required this.initialRoute,
  });

  /// Creates a [Config] instance from a map (typically from JSON).
  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      pagesPath: map['pagesPath'] as String,
      outputPath: map['outputPath'] as String,
      initialRoute: map['initialRoute'] as String? ?? '/',
    );
  }

  /// Converts the [Config] instance to a map for JSON serialization.
  Map<String, String> toMap() {
    return {
      'pagesPath': pagesPath,
      'outputPath': outputPath,
      'initialRoute': initialRoute,
    };
  }
}

/// Manages loading and saving of the configuration file.
class ConfigManager {
  static const _configFile = '.go_router_sugar_config.json';

  /// Loads configuration, prioritizing command-line args over the config file.
  static Future<Config?> load(ArgResults argResults) async {
    final pagesDir = argResults['pages-dir'] as String?;
    final outputFile = argResults['output'] as String?;
    final initialRoute = argResults['initial'] as String?;

    // If all required args are provided, use them.
    if (pagesDir != null && outputFile != null) {
      return Config(
        pagesPath: pagesDir,
        outputPath: outputFile,
        initialRoute: initialRoute ?? '/',
      );
    }

    // Otherwise, check for a config file.
    final file = File(_configFile);
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        return Config.fromMap(jsonDecode(content) as Map<String, dynamic>);
      } on Exception catch (_) {
        // If file is corrupt, treat as no config found.
        return null;
      }
    }
    
    // No valid config found from any source.
    return null;
  }

  /// Saves the provided [config] to the default config file.
  static Future<void> save(Config config) async {
    const encoder = JsonEncoder.withIndent('  ');
    final file = File(_configFile);
    await file.writeAsString(encoder.convert(config.toMap()));
  }
}