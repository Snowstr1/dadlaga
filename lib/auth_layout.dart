import 'package:flutter/material.dart';
import 'package:new_app/auth_services.dart';
import 'package:new_app/app_loading_page.dart';
import 'package:new_app/welcome_page.dart';
import 'package:new_app/profile_page.dart';  

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    this.pageIfNotConnected,
  });

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthService>(
      valueListenable: authService,
      builder: (context, authServiceValue, child) {
        return StreamBuilder(
          stream: authServiceValue.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingPage();
            } else if (snapshot.hasData) {
              return const ProfilePage();
            } else {
              return pageIfNotConnected ?? const WelcomePage();
            }
          },
        );
      },
    );
  }
}
