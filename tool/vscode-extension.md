# VS Code Extension for go_router_sugar

## Features Planned

### 1. **Page Creation Commands**
- `Go Router Sugar: Create Page` - Creates new page with template
- `Go Router Sugar: Create Layout` - Creates layout component
- `Go Router Sugar: Add Route Guard` - Adds authentication guard

### 2. **IntelliSense & Code Completion**
- Auto-complete for route constants: `Routes.` shows all available routes
- Auto-complete for navigation methods: `Navigate.` shows type-safe methods
- Parameter hints for dynamic routes

### 3. **Code Actions & Quick Fixes**
- Convert manual GoRoute to file-based route
- Add transition annotation to page
- Generate missing route parameters
- Fix route naming conventions

### 4. **File Templates**
- Page templates with common patterns (list, detail, form, etc.)
- Layout templates (drawer, tabs, bottom nav)
- Guard templates (auth, role-based, etc.)

### 5. **Route Visualization**
- Tree view of all routes in project
- Visual route hierarchy with parameters
- Navigation flow diagram
- Dead route detection

### 6. **Code Generation Integration**
- Run build_runner from command palette
- Auto-generate on file save (configurable)
- Show generation progress and errors
- Format generated code automatically

### 7. **Debugging Support**
- Route navigation history
- Parameter inspection
- Transition performance metrics
- Guard execution tracing

## Extension Commands

```json
{
  "commands": [
    {
      "command": "go-router-sugar.createPage",
      "title": "Create Page",
      "category": "Go Router Sugar"
    },
    {
      "command": "go-router-sugar.createLayout", 
      "title": "Create Layout",
      "category": "Go Router Sugar"
    },
    {
      "command": "go-router-sugar.generate",
      "title": "Generate Routes",
      "category": "Go Router Sugar"
    },
    {
      "command": "go-router-sugar.showRoutes",
      "title": "Show Route Tree", 
      "category": "Go Router Sugar"
    }
  ]
}
```

## Snippets

### Page Template
```dart
import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

@PageTransition(TransitionConfig.${1:fade})
class ${2:PageName}Page extends StatelessWidget {
  const ${2:PageName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${3:Page Title}')),
      body: const Center(
        child: Text('${4:Page Content}'),
      ),
    );
  }
}
```

### Dynamic Route Template  
```dart
import 'package:flutter/material.dart';
import 'package:go_router_sugar/go_router_sugar.dart';

@PageTransition(TransitionConfig.${1:slideRight})
class ${2:PageName}Page extends StatelessWidget {
  const ${2:PageName}Page({
    super.key,
    required this.${3:id},
  });

  final String ${3:id};

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${4:Page Title} $${3:id}')),
      body: Center(
        child: Text('${5:Content for} $${3:id}'),
      ),
    );
  }
}
```

This VS Code extension would make go_router_sugar the most developer-friendly routing solution in Flutter!
