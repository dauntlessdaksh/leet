import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/screens/compare/compare_screen.dart';

class CompareUsersScreen extends StatefulWidget {
  const CompareUsersScreen({super.key});

  @override
  State<CompareUsersScreen> createState() => _CompareUsersScreenState();
}

class _CompareUsersScreenState extends State<CompareUsersScreen> {
  final TextEditingController _user1Controller = TextEditingController();
  final TextEditingController _user2Controller = TextEditingController();

  @override
  void dispose() {
    _user1Controller.dispose();
    _user2Controller.dispose();
    super.dispose();
  }

  void _onCompare() {
    final u1 = _user1Controller.text.trim();
    final u2 = _user2Controller.text.trim();

    if (u1.isNotEmpty && u2.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompareScreen(username1: u1, username2: u2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both usernames')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(
        title: const Text('Compare'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _user1Controller,
               style: const TextStyle(color: AppTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'User 1',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _user2Controller,
               style: const TextStyle(color: AppTheme.textPrimary),
              decoration: const InputDecoration(
                labelText: 'User 2',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onCompare,
                child: const Text('Compare Users'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
