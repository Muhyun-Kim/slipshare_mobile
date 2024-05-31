import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slipshare_mobile/models/auth_state.dart' as local;
import 'package:slipshare_mobile/models/user_model.dart';
import 'package:slipshare_mobile/services/supabase/auth_service.dart';
import 'package:slipshare_mobile/services/supabase/supabase_client.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(supabase);
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, local.AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<local.AuthState> {
  final AuthService authService;

  AuthNotifier(this.authService)
      : super(const local.AuthState(isAuthenticated: false)) {
    _checkInitialAuthState();
  }
  Future<void> _checkInitialAuthState() async {
    final user = await supabase.auth.currentUser;
    if (user != null) {
      final userRes =
          await supabase.from('users').select().eq('user_id', user.id).single();
      final user_json = UserModel.fromJson(userRes);
      state = state.copyWith(isAuthenticated: true, user: user_json);
    }
  }

  Future<void> createAccount(
      String email, String password, String username, String detail) async {
    try {
      final user =
          await authService.createAccount(email, password, username, detail);
      state = state.copyWith(isAuthenticated: true, user: user);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await authService.login(email, password);
      state = state.copyWith(isAuthenticated: true, user: user);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    await authService.logout();
    state = state.copyWith(isAuthenticated: false, user: null);
  }
}
