import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/providers/auth_provider.dart';
import 'package:slipshare_mobile/services/supabase/supabase_client.dart';
import 'package:slipshare_mobile/views/create_account_page.dart';
import 'package:slipshare_mobile/views/home_page.dart';
import 'package:slipshare_mobile/views/login_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);
  final authSession = supabase.auth.currentSession != null;
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return authSession ? HomePage() : LoginPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountPage(),
      ),
    ],
  );
});
