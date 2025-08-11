import 'dart:async';
import 'dart:io';

// ANSI Escape Codes for styling
const _reset = '\x1B[0m';
const _bold = '\x1B[1m';
const _dim = '\x1B[2m';
const _cyan = '\x1B[36m';
const _blue = '\x1B[34m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';

// Special Characters for UI
const _s = '│'; // Separator
const _sSuccess = '✓'; // Success
const _sError = '✗'; // Error
const _sPrompt = '◆'; // Prompt

/// 🎨 Beautiful Interactive CLI for Go Router Sugar
class InteractiveCLI {
  /// 🌟 Main interactive wizard
  Future<Map<String, String>> runWizard() async {
    _clearScreen();
    _showWelcomeBanner();

    // Step 1: Choose pages directory
    final pagesPath = await _selectPagesDirectory();

    // Step 2: Choose initial route
    final initialRoute = await _selectInitialRoute();

    // Step 3: Choose output file
    final outputPath = await _selectOutputPath();

    // Step 4: Show summary and get confirmation
    final confirmed =
        await _showSummaryAndConfirm(pagesPath, initialRoute, outputPath);

    if (!confirmed) {
      _outroCancel();
      exit(0);
    }

    // Final generation step with spinner
    await _runWithSpinner(
      'Generating routes...',
      () async => await Future.delayed(
          const Duration(milliseconds: 750)), // Simulate work
    );

    _outroSuccess(pagesPath, initialRoute, outputPath);

    // This return value can be used to save the configuration
    return {
      'pagesPath': pagesPath,
      'initialRoute': initialRoute,
      'outputPath': outputPath,
    };
  }

  void _clearScreen() {
    try {
      if (Platform.isWindows) {
        stdout.write(Process.runSync('cls', [], runInShell: true).stdout);
      } else {
        stdout.write('\x1B[2J\x1B[0;0H');
      }
    } on ProcessException catch (_) {
      // Ignore if it fails on some terminals.
    }
  }

  void _showWelcomeBanner() {
    print(
        '$_cyan╭─────────────────────────────────────────────────────────────╮$_reset');
    print(
        '$_cyan$_s  🍬 Go Router Sugar - Interactive Setup Wizard             $_s$_reset');
    print(
        '$_cyan$_s  The Simplest Flutter Routing Ever!                        $_s$_reset');
    print(
        '$_cyan╰─────────────────────────────────────────────────────────────╯$_reset');
    print('');
  }

  /// Simplified directory selection logic.
  Future<String> _selectPagesDirectory() async {
    _intro('Step 1: Where are your page files located?');

    final optionsSet = <String>{};
    final descriptions = <String, String>{};

    // 1. Auto-detect a folder first.
    final detectedFolder = await _detectPagesFolder();
    if (detectedFolder != null) {
      optionsSet.add(detectedFolder);
      descriptions[detectedFolder] = '🎯 Auto-detected';
    }

    // 2. Suggest the standard 'lib/pages' structure.
    const suggestedDir = 'lib/pages';
    if (optionsSet.add(suggestedDir)) {
      final exists = await Directory(suggestedDir).exists();
      descriptions[suggestedDir] =
          exists ? '📁 Existing folder' : '🆕 Recommended structure';
    }

    // 3. Always offer a custom path.
    final options = optionsSet.toList();
    options.add('CUSTOM');
    descriptions['CUSTOM'] = '📝 Enter a custom path';

    final descList = options.map((opt) => descriptions[opt]!).toList();
    final selectedIndex = await _showMenu(options, descList);

    String selectedPath;
    if (options[selectedIndex] == 'CUSTOM') {
      selectedPath = await _askCustomPath('Enter pages directory path');
    } else {
      selectedPath = options[selectedIndex];
    }

    final dir = Directory(selectedPath);
    if (!await dir.exists()) {
      await _runWithSpinner('Creating directory: $selectedPath', () async {
        await dir.create(recursive: true);
      });
    }

    _logSuccess('Pages directory set to "$selectedPath"');
    return selectedPath;
  }

  Future<String> _selectInitialRoute() async {
    _intro('Step 2: What should be your app\'s starting page?');
    final options = ['/', '/home', '/welcome', '/splash', 'CUSTOM'];
    final descriptions = [
      '🏠 Root page (recommended)',
      '🏡 Home page',
      '👋 Welcome page',
      '💫 Splash screen',
      '📝 Enter custom route'
    ];
    final selectedIndex = await _showMenu(options, descriptions);

    String selectedRoute;
    if (options[selectedIndex] == 'CUSTOM') {
      selectedRoute =
          await _askCustomPath('Enter initial route (e.g., /login)');
    } else {
      selectedRoute = options[selectedIndex];
    }
    _logSuccess('Initial route set to "$selectedRoute"');
    return selectedRoute;
  }

  Future<String> _selectOutputPath() async {
    _intro('Step 3: Where should I save the generated routes file?');
    final options = [
      'lib/app_router.g.dart',
      'lib/routes/app_router.g.dart',
      'lib/routing/app_router.g.dart',
      'lib/core/app_router.g.dart',
      'CUSTOM'
    ];
    final descriptions = [
      '📄 Standard location (recommended)',
      '📁 In routes folder',
      '🛣️ In routing folder',
      '🏗️ In core folder',
      '📝 Enter custom path'
    ];
    final selectedIndex = await _showMenu(options, descriptions);

    String selectedPath;
    if (options[selectedIndex] == 'CUSTOM') {
      selectedPath = await _askCustomPath('Enter output file path');
    } else {
      selectedPath = options[selectedIndex];
    }
    _logSuccess('Output file set to "$selectedPath"');
    return selectedPath;
  }

  Future<bool> _showSummaryAndConfirm(
      String pagesPath, String initialRoute, String outputPath) async {
    _intro('Step 4: Confirm your configuration');
    print('$_dim┌───────────────────────────────────────$_reset');
    print('$_dim$_s$_reset $_bold$_yellow Pages Directory:$_reset $pagesPath');
    print(
        '$_dim$_s$_reset $_bold$_yellow Initial Route:  $_reset $initialRoute');
    print('$_dim$_s$_reset $_bold$_yellow Output File:    $_reset $outputPath');
    print('$_dim└───────────────────────────────────────$_reset');
    print('');
    final selectedIndex =
        await _showMenu(['Yes, generate routes', 'No, cancel'], []);
    return selectedIndex == 0;
  }

  // --- UI HELPER WIDGETS ---

  void _intro(String message) {
    print('');
    print('$_blue$_sPrompt$_reset $_bold$message$_reset');
    print('$_dim$_s$_reset');
  }

  void _logSuccess(String message) {
    print('$_dim$_s$_reset   $_green$_sSuccess$_reset $_dim$message$_reset');
    print('');
  }

  void _outroSuccess(String pagesPath, String initialRoute, String outputPath) {
    print('');
    print('$_green$_sSuccess Success! Your configuration is complete.$_reset');
    print('$_dim┌───────────────────────────────────────$_reset');
    print('$_dim$_s$_reset $_bold$_yellow Pages Directory:$_reset $pagesPath');
    print(
        '$_dim$_s$_reset $_bold$_yellow Initial Route:  $_reset $initialRoute');
    print('$_dim$_s$_reset $_bold$_yellow Output File:    $_reset $outputPath');
    print('$_dim└───────────────────────────────────────$_reset');
    print('\n$_dim Happy routing! ✨$_reset');
  }

  void _outroCancel() {
    print('');
    print('$_red$_sError Operation cancelled.$_reset');
  }

  Future<void> _runWithSpinner(
      String message, Future<void> Function() action) async {
    final bool supportsCarriageReturn = stdout.supportsAnsiEscapes;
    if (!supportsCarriageReturn) {
      stdout.write('$message...');
      await action();
      stdout.write(' done.\n');
      return;
    }
    stdout.write('$_dim$_s$_reset   $_cyan');
    final spinner = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'];
    int i = 0;
    final timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      stdout.write(
          '\r$_dim$_s$_reset   $_cyan${spinner[i % spinner.length]}$_reset $_dim$message$_reset');
      i++;
    });
    try {
      await action();
      timer.cancel();
      stdout.write(
          '\r$_dim$_s$_reset   $_green$_sSuccess$_reset $_dim$message$_reset\n');
    } catch (e) {
      timer.cancel();
      stdout.write(
          '\r$_dim$_s$_reset   $_red$_sError$_reset $_dim$message$_reset\n');
      rethrow;
    }
  }

  Future<int> _showMenu(List<String> options, List<String> descriptions) async {
    for (int i = 0; i < options.length; i++) {
      final isCustom = options[i] == 'CUSTOM';
      final optionText = isCustom ? 'Custom path...' : options[i];
      print('  $_cyan${i + 1}.$_reset $_bold$optionText$_reset');
      if (descriptions.isNotEmpty && descriptions[i].isNotEmpty) {
        print('     $_dim└─ ${descriptions[i]}$_reset');
      }
      print('');
    }
    int? choice;
    while (choice == null) {
      print('$_dim$_s$_reset');
      stdout.write('$_dim└─$_reset $_bold Enter your choice ›$_reset ');
      final input = stdin.readLineSync();
      if (input == null) {
        _outroCancel();
        exit(0);
      }
      final number = int.tryParse(input.trim());
      if (number != null && number > 0 && number <= options.length) {
        choice = number;
      } else {
        stdout.write('\x1B[2A\x1B[J');
        print(
            '  $_red$_sError Invalid input. Please enter a number from 1 to ${options.length}.$_reset\n');
      }
    }
    final linesToClear = (options.length * 2) + 2;
    stdout.write('\x1B[${linesToClear}A\x1B[J');
    return choice - 1;
  }

  Future<String> _askCustomPath(String prompt) async {
    while (true) {
      stdout.write('$_dim$_s$_reset   $_bold$prompt $_dim›$_reset ');
      final input = stdin.readLineSync()?.trim() ?? '';
      if (input.isNotEmpty) {
        return input;
      }
      print('  $_red$_sError Please enter a valid path.$_reset');
    }
  }

  // --- LOGIC HELPERS ---

  Future<String?> _detectPagesFolder() async {
    final commonPatterns = [
      'lib/presentation/pages',
      'lib/ui/pages',
      'lib/screens',
    ];
    for (final pattern in commonPatterns) {
      try {
        if (await Directory(pattern).exists()) {
          return pattern;
        }
      } on FileSystemException {
        continue;
      }
    }
    // Return null if no common pattern is found
    return null;
  }
}
