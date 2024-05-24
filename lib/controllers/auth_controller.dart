import 'package:slipshare_mobile/services/supabase/auth_service.dart';

class AuthController {
  static Future<void> createAccount({
    required String email,
    required String username,
    String? detail,
    required String password,
    required Function(String error) onError,
    required Function onSuccess,
  }) async {
    try {
      await AuthService.createAccount(
        email: email,
        username: username,
        password: password,
      );
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> login({
    required String email,
    required String password,
    required Function(String error) onError,
    required Function onSuccess,
  }) async {
    try {
      await AuthService.login(
        email: email,
        password: password,
      );
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> logout() async {
    try {
      await AuthService.logout();
    } catch (e) {}
  }
}
