import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    AuthController.login(
        email: _emailController.text,
        password: _passwordController.text,
        onError: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ログインに失敗しました'),
            ),
          );
        },
        onSuccess: () {
          context.go('/');
        });
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return '有効なメールアドレスを記入してください';
    }
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                ),
                validator: _emailValidator,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('ログイン'),
              ),
              const Text('アカウントをお持ちでないですか？'),
              ElevatedButton(
                onPressed: () => context.go('/create-account'),
                child: const Text('アカウント作成'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/create-account'),
      ),
    );
  }
}
