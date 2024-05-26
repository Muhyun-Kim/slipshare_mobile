import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slipshare_mobile/providers/auth_provider.dart';

class AuthController {
  final AuthNotifier authNotifier;

  AuthController(this.authNotifier);

  Future<void> createAccount({
    required String email,
    required String username,
    String? detail,
    required String password,
    required Function(String error) onError,
    required Function onSuccess,
  }) async {
    try {
      await authNotifier.createAccount(email, password, username, detail ?? '');
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required Function(String error) onError,
    required Function onSuccess,
  }) async {
    try {
      await authNotifier.login(
        email,
        password,
      );
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> logout({
    required Function(String error) onError,
    required Function onSuccess,
  }) async {
    try {
      await authNotifier.logout();
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }
}

final authControllerProvider = Provider<AuthController>((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  return AuthController(authNotifier);
});
