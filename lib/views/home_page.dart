import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/controllers/auth_controller.dart';
import 'package:slipshare_mobile/providers/auth_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _logout() {
    final authController = ref.read(authControllerProvider);
    authController.logout(
      onError: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ログインに失敗しました'),
          ),
        );
      },
      onSuccess: () => context.go('/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    print(authState.user?.username);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ホーム'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  authState.user!.username,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text('logout'),
                  onTap: _logout,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _logout,
          child: const Text('logout'),
        ),
      ),
    );
  }
}
