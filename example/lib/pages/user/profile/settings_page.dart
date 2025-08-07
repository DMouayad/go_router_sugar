import 'package:flutter/material.dart';

/// The user profile settings page widget.
class UserProfileSettingsPage extends StatefulWidget {
  /// Creates a user profile settings page widget.
  const UserProfileSettingsPage({super.key});

  @override
  State<UserProfileSettingsPage> createState() =>
      _UserProfileSettingsPageState();
}

class _UserProfileSettingsPageState extends State<UserProfileSettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive notifications about updates'),
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          const Divider(height: 32),
          const Text(
            'Account',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Edit Profile'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile - Coming Soon!')),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            leading: const Icon(Icons.security),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Privacy Settings - Coming Soon!')),
              );
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () {
              _showSignOutDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final languages = ['English', 'Spanish', 'French', 'German'];

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages
              .map(
                (lang) => RadioListTile<String>(
                  title: Text(lang),
                  value: lang,
                  groupValue: _language,
                  onChanged: (value) {
                    setState(() {
                      _language = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
