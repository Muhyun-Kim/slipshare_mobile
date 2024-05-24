import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "login page",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/create-account'),
      ),
    );
  }
}
