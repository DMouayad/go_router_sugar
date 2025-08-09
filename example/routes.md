# 🗺️ Route Map

> Auto-generated route documentation by Go Router Sugar

## 📋 All Routes

| Route | File | Description |
|-------|------|-------------|
| `/about` | `lib\pages\about_page.dart` | AboutPage |
| `/animated` | `lib\pages\animated_page.dart` | AnimatedPage |
| `/main` | `lib\pages\main_page.dart` | MainPage |
| `/premium` | `lib\pages\premium_page.dart` | PremiumPage |
| `/products/:id` | `lib\pages\products\[id]_page.dart` | ProductPage |
| `/profile` | `lib\pages\profile_page.dart` | ProfilePage |
| `/user/profile/settings` | `lib\pages\user\profile\settings_page.dart` | UserProfileSettingsPage |

## 🌳 Route Tree

```
🏠 /
│   ├── /about
│   ├── /animated
│   ├── /main
│   ├── /premium
│   ├── /products
│   │   └── /products/:id
│   ├── /profile
│   └── /user
│       └── /user/profile
│           └── /user/profile/settings
```

## 🚀 Usage

```dart
// Navigate to any route with type safety:
Navigate.goToAbout();
Navigate.goToAnimated();
Navigate.goToMain();
// ... and 4 more routes!
```

---
*Generated on 2025-08-09 18:26:40 by [Go Router Sugar](https://pub.dev/packages/go_router_sugar)*
