import 'package:flutter/material.dart';
import 'package:new_app/auth_services.dart';
import 'change_username_page.dart';
import 'change_password_page.dart';
import 'delete_account_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

 void _logout(BuildContext context) async {
  await authService.value.signOut();
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}


  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;
    final username = user?.displayName ?? user?.email ?? 'User';

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, $username!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Divider(height: 20, thickness: 2),
            ListTile(
              title: Text('Update Username'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdateUsernamePage()),
              ),
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
              ),
            ),
            ListTile(
              title: Text('Delete Account'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeleteAccountPage()),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
