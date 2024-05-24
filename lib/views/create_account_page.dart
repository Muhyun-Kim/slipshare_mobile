import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate())
      print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
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

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    }
    if (value.length < 8) {
      return 'パスワードは8文字以上';
    }
    if (RegExp(r'[^a-zA-Z0-9!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'パスワードに使えない文字が入っています';
    }
    return null;
  }

  String? _passwordConfirmValidator(String? value) {
    if (value != _passwordController.text) {
      return 'パスワードと一致していません';
    }
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                validator: _passwordValidator,
              ),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: const InputDecoration(
                  labelText: 'パスワード確認',
                ),
                obscureText: true,
                validator: _passwordConfirmValidator,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('会員登録'),
              ),
              Text('すでにアカウントをお持ちですか？'),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: Text('ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
