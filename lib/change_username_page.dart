import 'package:flutter/material.dart';
import 'package:new_app/auth_services.dart';

class UpdateUsernamePage extends StatefulWidget {
  const UpdateUsernamePage({super.key});

  @override
  State<UpdateUsernamePage> createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final usernameController = TextEditingController();
  String? message;

  void updateUsername() async {
    try {
      await authService.value.updateUsername(username: usernameController.text.trim());
      setState(() => message = "Username updated successfully!");
    } catch (e) {
      setState(() => message = "Failed to update username.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Username')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUsername,
              child: Text('Update'),
            ),
            if (message != null) ...[
              SizedBox(height: 20),
              Text(message!, style: TextStyle(color: Colors.green)),
            ],
          ],
        ),
      ),
    );
  }
}
