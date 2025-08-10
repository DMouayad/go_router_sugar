#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:go_router_sugar/src/commands/base_command.dart';
import 'package:go_router_sugar/src/commands/generate_command.dart';
import 'package:go_router_sugar/src/commands/new_command.dart';
import 'package:go_router_sugar/src/commands/visual_command.dart';
import 'package:go_router_sugar/src/commands/watch_command.dart';
import 'package:go_router_sugar/src/util/pretty_print.dart';

const String _version = '1.2.1';

void main(List<String> arguments) async {
  final parser = _createArgParser();
  try {
    final argResults = parser.parse(arguments);
    final command = argResults.command;

    if (command == null) {
      if (argResults['version'] as bool) {
        print('🍬 go_router_sugar v$_version');
        return;
      }
      _printUsage(parser);
      return;
    }

    final Map<String, BaseCommand> commands = {
      'generate': GenerateCommand(),
      'watch': WatchCommand(),
      'visual': VisualCommand(),
      'new': NewCommand(),
    };

    await commands[command.name]!.run(command);
  } on FormatException catch (e) {
    printError('Invalid command: ${e.message}');
    _printUsage(parser);
  } on Exception catch (e) {
    printError('An unexpected error occurred: $e');
  }
}

ArgParser _createArgParser() {
  return ArgParser()
    ..addCommand('generate', GenerateCommand().argParser)
    ..addCommand('watch', WatchCommand().argParser)
    ..addCommand('visual', VisualCommand().argParser)
    ..addCommand('new', NewCommand().argParser)
    ..addFlag('version', negatable: false, help: 'Prints the package version.');
}

void _printUsage(ArgParser parser) {
  print('🍬 Go Router Sugar - The Simplest Flutter Routing Ever!\n');
  print('Usage: go_router_sugar <command> [arguments]\n');
  print('Available commands:');
  parser.commands.forEach((name, commandParser) {
    final description = commandParser.usage.split('\n').firstWhere(
          (line) => line.isNotEmpty,
          orElse: () => '',
        );
    print('  ${name.padRight(10)} $description');
  });
  print('\nRun "go_router_sugar <command> --help" for more information.');
}