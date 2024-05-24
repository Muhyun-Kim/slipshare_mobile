import 'package:slipshare_mobile/models/user_model.dart';
import 'package:slipshare_mobile/services/supabase/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static Future<void> createAccount({
    required String email,
    required String username,
    String? detail,
    required String password,
  }) async {
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);
    print('supabase:${res.user}');
    if (res.user == null) {
      throw Exception('アカウント作成に失敗しました');
    } else {
      final User supabaseUser = res.user!;
      final user_id = supabaseUser.id;
      final user = UserModel(
        id: 0,
        username: username,
        user_id: user_id,
        detail: "",
      );
      await supabase.from('users').insert(user.toJson());
    }
  }

  static Future<void> logout() async {
    supabase.auth.signOut();
  }
}
