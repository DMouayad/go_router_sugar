import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import '../core/templates.dart';
import '../util/pretty_print.dart';
import 'base_command.dart';
import 'generate_command.dart';

/// Handles the `new` command to create a starter Flutter project.
class NewCommand extends BaseCommand {
  @override
  final name = 'new';
  @override
  final description =
      'Creates a new Flutter project with go_router_sugar pre-configured.';

  @override
  ArgParser get argParser {
    return ArgParser()
      ..addOption('template',
          abbr: 't',
          help: 'The template to use.',
          defaultsTo: 'minimal',
          allowed: ['minimal'])
      ..addFlag('help', abbr: 'h', help: 'Show help for this command.', negatable: false);
  }

  @override
  Future<void> run(ArgResults argResults) async {
    if (argResults['help'] as bool) {
      print('🍬 New Command Help');
      print('');
      print('Creates a new Flutter project with go_router_sugar pre-configured.');
      print('');
      print('Usage: go_router_sugar new <app_name> [options]');
      print('');
      print('Options:');
      print(argParser.usage);
      return;
    }

    if (argResults.rest.isEmpty) {
      printError('Please provide a name for your new application.');
      printInfoMessage('Example: go_router_sugar new my_awesome_app');
      return;
    }
    final appName = argResults.rest.first;
    final templateName = argResults['template'] as String;
    final template = AppTemplate.getByName(templateName)!;

    printInfoMessage(
        '\n🚀 Creating a new Flutter app "$appName" using the "$templateName" template...');

    final createResult = await Process.run('flutter', ['create', appName]);
    if (createResult.exitCode != 0) {
      printError(
          'Failed to create Flutter app. Please check your Flutter installation.');
      print(createResult.stderr);
      return;
    }
    printSuccess('Flutter project created.');

    printInfoMessage('📁 Setting up routing files...');
    for (final page in template.pages) {
      final filePath = p.join(appName, page.filePath);
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsString(page.content);
    }
    printSuccess('Page templates created.');

    printInfoMessage('⚙️  Generating initial routes...');
    final projectDir = Directory(appName);
    final originalDir = Directory.current;
    
    try {
      Directory.current = projectDir; // Temporarily change directory
      // Run the generate command with default options in the new project
      await GenerateCommand().run(GenerateCommand().argParser.parse([]));
    } finally {
      Directory.current = originalDir; // Always change back
    }

    printSuccess('Your new app is ready!');
    printInfoMessage(
        '\nNext steps:\n  1. cd $appName\n  2. flutter pub get\n  3. flutter run');
  }
}