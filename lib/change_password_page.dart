import 'package:flutter/material.dart';
import 'package:new_app/auth_services.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  String? _message;

  void _changePassword() async {
    try {
      final email = authService.value.currentUser!.email!;
      await authService.value.resetPasswordFromCurrentPassword(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
        email: email,
      );
      setState(() => _message = "Password changed successfully!");
    } catch (e) {
      setState(() => _message = "Failed to change password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _currentController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              controller: _newController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Change Password'),
            ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(_message!, style: TextStyle(color: Colors.green)),
            ],
          ],
        ),
      ),
    );
  }
}
