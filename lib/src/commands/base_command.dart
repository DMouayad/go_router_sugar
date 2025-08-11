import 'package:args/args.dart';

/// A base class for all CLI command implementations.
///
/// This ensures a consistent structure for all commands in the tool.
abstract class BaseCommand {
  /// The name of the command (e.g., 'generate').
  String get name;

  /// A brief description of what the command does, shown in the main help.
  String get description;

  /// The `ArgParser` for this command's specific options and flags.
  ArgParser get argParser;

  /// The method to execute when the command is run.
  Future<void> run(ArgResults argResults);
}
