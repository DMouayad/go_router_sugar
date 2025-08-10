/// ANSI Escape Codes for styling console output.
const kReset = '\x1B[0m';
const kBold = '\x1B[1m';
const kDim = '\x1B[2m';
const kCyan = '\x1B[36m';
const kGreen = '\x1B[32m';
const kRed = '\x1B[31m';
const kYellow = '\x1B[33m';

/// Box-drawing characters for creating structured layouts in the console.
const _bar = '│';
const _top = '┌';
const _mid = '├';
const _bot = '└';
const _line = '─';

/// Prints a styled section header. e.g., "┌ Analysis"
void printSectionStart(String title) {
  print('');
  print('$kDim$_top$_line $title$kReset');
  print('$kDim$_bar$kReset');
}

/// Prints a styled message within a section.
void printInfo(String message, {bool isLast = false}) {
  final prefix = isLast ? _bot : _mid;
  print('$kDim$prefix$_line$kReset $message');
}

/// Prints a styled sub-message, indented within a section.
void printSubInfo(String message, {bool isLast = false}) {
  final prefix = isLast ? _bot : _mid;
  print('$kDim$_bar  $prefix$_line$kReset $message');
}

/// Prints a blank vertical bar for spacing within a section.
void printSectionSpacing() {
  print('$kDim$_bar$kReset');
}

/// Prints a final, colored success message.
void printSuccess(String message) {
  print('');
  print('$kGreen🎉 Success! $message$kReset');
}

/// Prints a colored error message.
void printError(String message) => print('$kRed❌ Error: $message$kReset');

/// Prints a colored warning message.
void printWarning(String message) => print('$kYellow⚠️  Warning: $message$kReset');

/// Prints a colored informational message.
void printInfoMessage(String message) => print('$kCyan$message$kReset');