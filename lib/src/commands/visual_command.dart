import 'package:args/args.dart';
import '../core/config_manager.dart';
import '../core/route_analyzer.dart';
import '../route_info.dart';
import '../util/pretty_print.dart';
import 'base_command.dart';

class VisualCommand extends BaseCommand {
  @override
  final name = 'visual';
  @override
  final description = 'Displays a visual tree of all discovered routes.';
  @override
  ArgParser get argParser => ArgParser()
    ..addOption('pages-dir', help: 'Directory containing page files.')
    ..addOption('output', help: 'Output file for generated routes.')
    ..addOption('initial', help: 'Initial route for the app.')
    ..addFlag('help',
        abbr: 'h', help: 'Show help for this command.', negatable: false);

  @override
  Future<void> run(ArgResults argResults) async {
    if (argResults['help'] as bool) {
      print('🍬 Visual Command Help');
      print('');
      print('Displays a visual tree of all discovered routes.');
      print('');
      print('Usage: go_router_sugar visual [options]');
      print('');
      print('Options:');
      print(argParser.usage);
      return;
    }

    final config = await ConfigManager.load(argResults);
    if (config == null) {
      printError('Configuration not found.');
      printInfoMessage(
          'Run "go_router_sugar generate" first to create a configuration file.');
      return;
    }
    printInfoMessage('\n🗺️  Generating visual route map...');
    final analyzer = RouteAnalyzer();
    final routes = await analyzer.analyze(config.pagesPath);
    if (routes.isEmpty) {
      printWarning('No routes found to visualize.');
      return;
    }
    printSectionStart('Route Map');
    _printRouteTree(routes);
  }

  void _printRouteTree(List<RouteInfo> routes) {
    final tree = <String, Set<String>>{};

    // Build tree structure avoiding duplicates
    for (final route in routes) {
      final segments =
          route.routePath.split('/').where((String s) => s.isNotEmpty).toList();
      String currentPath = '';

      for (int i = 0; i < segments.length; i++) {
        final parent = currentPath.isEmpty ? '/' : currentPath;
        currentPath = currentPath.isEmpty
            ? '/${segments[i]}'
            : '$currentPath/${segments[i]}';

        // Add to tree only if not already present
        tree.putIfAbsent(parent, () => <String>{}).add(currentPath);
      }
    }

    // Convert sets to sorted lists for consistent output
    final sortedTree = <String, List<String>>{};
    tree.forEach((key, value) {
      sortedTree[key] = value.toList()..sort();
    });

    _printNode('/', sortedTree, '', true);
  }

  void _printNode(
      String path, Map<String, List<String>> tree, String prefix, bool isLast) {
    final displayName = path == '/' ? '🏠 / (root)' : path.split('/').last;
    print('$kDim$prefix${isLast ? '└─' : '├─'}$kReset $displayName');
    final children = tree[path] ?? [];
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      _printNode(child, tree, '$kDim$prefix${isLast ? '   ' : '│  '}$kReset',
          i == children.length - 1);
    }
  }
}
