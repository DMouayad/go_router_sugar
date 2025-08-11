import 'package:args/args.dart';
import '../../interactive_cli.dart';
import '../core/code_generator.dart';
import '../core/config_manager.dart';
import '../core/route_analyzer.dart';
import '../util/pretty_print.dart';
import 'base_command.dart';

/// Contains all logic for the `generate` command.
class GenerateCommand extends BaseCommand {
  @override
  String get name => 'generate';

  @override
  String get description => 'Generate route configuration from page files';

  /// The argument parser for the `generate` command.
  @override
  final ArgParser argParser = ArgParser()
    ..addOption('pages-dir', help: 'Directory containing page files.')
    ..addOption('output', help: 'Output file for generated code.')
    ..addOption('initial', help: 'The initial route for the app.')
    ..addFlag('help',
        abbr: 'h', help: 'Show help for this command.', negatable: false);

  /// The main execution method for the command.
  @override
  Future<void> run(ArgResults argResults) async {
    if (argResults['help'] as bool) {
      print('🍬 Generate Command Help');
      print('');
      print('Generate GoRouter configuration from page files.');
      print('');
      print('Usage: go_router_sugar generate [options]');
      print('');
      print('Options:');
      print(argParser.usage);
      return;
    }

    // 1. Load configuration from args or file.
    Config? config = await ConfigManager.load(argResults);
    bool wasFirstRun = false;

    // 2. If no config is found, launch the interactive wizard.
    if (config == null) {
      final newConfigMap = await InteractiveCLI().runWizard();
      config = Config.fromMap(newConfigMap);
      wasFirstRun = true;
    }

    printInfoMessage('\n🍬 go_router_sugar: Analyzing project...');

    // 3. Analyze the project to find routes.
    final analyzer = RouteAnalyzer();
    final routes = await analyzer.analyze(config.pagesPath);

    if (routes.isEmpty) {
      printWarning('No page files found in "${config.pagesPath}".');
      printInfoMessage(
          '💡 Create a page file ending with "_page.dart" to get started.');
      return;
    }

    printSectionStart('Analysis');
    printInfo('Found ${routes.length} page files in "${config.pagesPath}":');
    for (final route in routes) {
      final fileName = route.filePath.split('/').last;
      printSubInfo('📄 $fileName → ${route.routePath}',
          isLast: route == routes.last);
    }
    printSectionSpacing();
    printInfo('Analysis complete.', isLast: true);

    // 4. Generate the code.
    final generator = CodeGenerator(routes: routes, config: config);
    await generator.generate();

    printSectionStart('Generation');
    printInfo('✓ Routes saved to "${config.outputPath}"', isLast: true);

    // 5. If it was the first run, save the config.
    if (wasFirstRun) {
      await ConfigManager.save(config);
      printSuccess('Configuration saved!');
    }

    _printNextSteps(isFirstRun: wasFirstRun);
  }

  /// Prints the final help text after a successful generation.
  void _printNextSteps({bool isFirstRun = false}) {
    printSuccess('All routes are up to date.');
    print('$kDim┌─ Next Steps$kReset');
    printInfo('1. Import the router in your app:');
    printSubInfo("import 'app_router.g.dart';", isLast: true);
    printSectionSpacing();
    printInfo('2. Use the router in MaterialApp:');
    printSubInfo('MaterialApp.router(routerConfig: router)', isLast: true);
    if (isFirstRun) {
      printSectionSpacing();
      printInfo('3. Explore other commands:', isLast: true);
      print(
          '   $kDim└─$kReset dart run go_router_sugar watch  (For auto-updates)');
    }
    print('');
  }
}
