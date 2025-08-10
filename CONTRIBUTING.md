# 🤝 Contributing to Go Router Sugar

Thank you for your interest in contributing to Go Router Sugar! This guide will help you get started with contributing to the project.

## 🎯 Project Vision

Go Router Sugar aims to be **the simplest Flutter routing solution ever** - so easy that even kids can use it! Every contribution should support this vision of eliminating complexity and providing magical developer experience.

## 🚀 Getting Started

### Prerequisites

- Dart SDK >=3.0.0
- Flutter >=3.10.0
- Git

### Setup Development Environment

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/go_router_sugar.git
   cd go_router_sugar
   ```

2. **Install Dependencies**
   ```bash
   dart pub get
   ```

3. **Verify Setup**
   ```bash
   dart analyze
   dart test
   ```

4. **Test CLI Commands**
   ```bash
   dart run bin/go_router_sugar.dart --help
   dart run bin/go_router_sugar.dart generate --help
   ```

## 📁 Project Structure

```
lib/
├── src/
│   ├── commands/           # CLI command implementations
│   │   ├── base_command.dart
│   │   ├── generate_command.dart
│   │   ├── watch_command.dart
│   │   ├── visual_command.dart
│   │   └── new_command.dart
│   ├── core/              # Core functionality
│   │   ├── route_analyzer.dart
│   │   ├── code_generator.dart
│   │   ├── config_manager.dart
│   │   └── templates.dart
│   ├── util/              # Utilities
│   │   └── pretty_print.dart
│   ├── route_info.dart    # Route data structures
│   ├── smart_guards.dart  # Route guard system
│   └── ...               # Other core files
├── go_router_sugar.dart   # Main library exports
bin/
└── go_router_sugar.dart   # CLI entry point
test/                      # Test files
example/                   # Example usage
```

## 🛠️ Development Guidelines

### Code Style

- **Follow Dart conventions**: Use `dart format` and `dart analyze`
- **Meaningful names**: Variables and functions should be self-documenting
- **Comments for complex logic**: Explain "why", not "what"
- **Error handling**: Always handle edge cases gracefully

### Architecture Principles

1. **Single Source of Truth**: No duplicate classes or conflicting implementations
2. **Clean Dependencies**: Each module should have clear, minimal dependencies
3. **User-First**: Every API should be intuitive and hard to misuse
4. **Fail Fast**: Provide clear error messages when something goes wrong

### Testing

- **Unit tests** for core logic
- **Integration tests** for CLI commands
- **Example projects** for end-to-end validation

```bash
# Run all tests
dart test

# Run specific test file
dart test test/route_analyzer_test.dart

# Test CLI commands
cd example && dart run go_router_sugar generate
```

## 🎯 Types of Contributions

### 🐛 Bug Fixes

1. **Check existing issues** before creating new ones
2. **Provide minimal reproduction** with example code
3. **Include error messages** and stack traces
4. **Test the fix** with example projects

### ✨ New Features

1. **Discuss first**: Open an issue to discuss the feature before implementing
2. **Keep it simple**: Features should reduce complexity, not add it
3. **Update documentation**: Include README, tests, and examples
4. **Backward compatibility**: Don't break existing APIs

### 📖 Documentation

- **Fix typos and improve clarity**
- **Add missing examples**
- **Update outdated information**
- **Improve CLI help messages**

### 🎨 Examples

- **Real-world use cases**
- **Integration with popular packages**
- **Best practice demonstrations**

## 📝 Pull Request Process

### Before Submitting

1. **Test thoroughly**
   ```bash
   dart analyze
   dart test
   dart run bin/go_router_sugar.dart generate --help
   ```

2. **Update documentation** if needed
3. **Add/update tests** for new functionality
4. **Check the example project** still works

### PR Guidelines

1. **Clear title**: Describe what the PR does
2. **Detailed description**: Explain the changes and why they're needed
3. **Link related issues**: Reference any related issues
4. **Small, focused changes**: One feature/fix per PR

### PR Template

```markdown
## 📝 Description
Brief description of what this PR does.

## 🎯 Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## ✅ Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] Example project works

## 📚 Documentation
- [ ] README updated if needed
- [ ] Code comments added
- [ ] CLI help updated
```

## 🚨 Important Guidelines

### What We Accept

- ✅ **Bug fixes** with clear reproduction steps
- ✅ **Performance improvements** with benchmarks
- ✅ **Documentation improvements**
- ✅ **New features** that align with project vision
- ✅ **Test coverage** improvements

### What We Don't Accept

- ❌ **Breaking changes** without major version bump
- ❌ **Features that add complexity** without clear benefit
- ❌ **Code that doesn't follow Dart conventions**
- ❌ **Large PRs** that change multiple unrelated things

### Code Review Process

1. **Automated checks** must pass (tests, linting)
2. **Maintainer review** for code quality and design
3. **Community feedback** period for major changes
4. **Final approval** and merge

## 🌟 Recognition

Contributors are recognized in:
- **CHANGELOG.md** for significant contributions
- **README.md** contributors section
- **GitHub contributors** page

## 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Discord/Slack**: (Links to be added if available)

## 📜 Code of Conduct

Be respectful, inclusive, and constructive. We're all here to make Flutter development better!

---

**Thank you for contributing to Go Router Sugar! 🍬**

Every contribution, no matter how small, helps make Flutter routing simpler for everyone.
