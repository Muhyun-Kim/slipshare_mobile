import 'package:slipshare_mobile/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase;
  AuthService(this.supabase);

  Future<UserModel?> createAccount(
      String email, String password, String username, String detail) async {
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);

    if (res.user == null) {
      return throw Exception('アカウント作成に失敗しました');
    }
    final user = UserModel(
      id: 0,
      username: username,
      user_id: res.user!.id,
      detail: "",
    );
    final userRes = await supabase.from('users').insert(user.toJson());
    if (userRes == null) {
      return throw Exception('アカウント作成に失敗しました');
    }
    return UserModel.fromJson(userRes.data[0]);
  }

  Future<UserModel?> login(String email, String password) async {
    final AuthResponse res = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (res.user == null) {
      return throw Exception('ログインに失敗しました');
    }
    final user = await supabase
        .from('user')
        .select()
        .eq('user_id', res.user!.id)
        .single();
    return UserModel.fromJson(user);
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
