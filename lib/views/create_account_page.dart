import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/controllers/auth_controller.dart';

class CreateAccountPage extends ConsumerStatefulWidget {
  const CreateAccountPage({super.key});

  @override
  ConsumerState<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final authcontroller = ref.read(authControllerProvider);
      authcontroller.createAccount(
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        onError: (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('アカウント作成に失敗しました'),
            ),
          );
        },
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('アカウント作成に成功しました'),
              action: SnackBarAction(
                label: 'ログイン画面に戻る',
                onPressed: () => context.go('/login'),
              ),
            ),
          );
        },
      );
    }
  }

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'ユーザー名を入力してください';
    }
    if (value.length < 3 || value.length > 12) {
      return 'ユーザー名は3文字以上12文字以下にしてください';
    }
    return null;
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

  @override
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'ユーザー名',
                ),
                validator: _usernameValidator,
              ),
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
                child: const Text('会員登録'),
              ),
              const Text('すでにアカウントをお持ちですか？'),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
