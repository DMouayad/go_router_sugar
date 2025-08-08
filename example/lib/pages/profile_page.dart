import 'package:flutter/material.dart';

/// User profile page demonstrating basic routing.
class ProfilePage extends StatelessWidget {
  /// Creates a profile page.
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text(
          'profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
