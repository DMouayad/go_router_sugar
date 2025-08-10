import 'dart:io';
import 'package:args/args.dart';
import '../core/code_generator.dart';
import '../core/config_manager.dart';
import '../core/route_analyzer.dart';
import '../util/pretty_print.dart';
import 'base_command.dart';

/// Handles the `watch` command for real-time route generation.
class WatchCommand extends BaseCommand {
  @override
  final name = 'watch';
  @override
  final description =
      'Watches for file changes and automatically regenerates routes.';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('pages-dir', help: 'Directory containing page files.')
    ..addOption('output', help: 'Output file for generated routes.')
    ..addOption('initial', help: 'Initial route for the app.')
    ..addFlag('help', abbr: 'h', help: 'Show help for this command.', negatable: false); // Support config args

  @override
  Future<void> run(ArgResults argResults) async {
    if (argResults['help'] as bool) {
      print('🍬 Watch Command Help');
      print('');
      print('Watches for file changes and automatically regenerates routes.');
      print('');
      print('Usage: go_router_sugar watch [options]');
      print('');
      print('Options:');
      print(argParser.usage);
      return;
    }

    final config = await ConfigManager.load(argResults);
    if (config == null) {
      printError('Configuration not found.');
      printInfoMessage(
          'Please run "go_router_sugar generate" first to create a configuration file.');
      return;
    }

    printInfoMessage('\n👀 Starting watch mode...');
    printInfoMessage('   Watching for changes in "${config.pagesPath}"');
    printInfoMessage('   Press Ctrl+C to exit.');

    // Perform an initial generation to ensure everything is up-to-date.
    await _regenerate(config);

    final watcher = Directory(config.pagesPath).watch(recursive: true);
    await for (final event in watcher) {
      // We only care about page files being created, deleted, or modified.
      if (event.path.endsWith('_page.dart')) {
        printInfoMessage('\n🔄 File change detected: ${event.path}');
        await _regenerate(config);
      }
    }
  }

  /// Analyzes the project and regenerates the router file.
  Future<void> _regenerate(Config config) async {
    try {
      final analyzer = RouteAnalyzer();
      final routes = await analyzer.analyze(config.pagesPath);
      final generator = CodeGenerator(routes: routes, config: config);
      await generator.generate();
      printSuccess('Routes regenerated successfully!');
    } on Exception catch (e) {
      printError('Failed to regenerate routes: $e');
    }
  }
}