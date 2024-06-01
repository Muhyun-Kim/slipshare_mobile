import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/providers/auth_provider.dart';
import 'package:slipshare_mobile/views/create_account_page.dart';
import 'package:slipshare_mobile/views/home_page.dart';
import 'package:slipshare_mobile/views/login_page.dart';
import 'package:slipshare_mobile/views/profile_page.dart';
import 'package:slipshare_mobile/views/recipes_list_page.dart';
import 'package:slipshare_mobile/views/recipes_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return authState.isAuthenticated
              ? const HomePage()
              : const LoginPage();
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
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/recipes',
        builder: (context, state) => const RecipesPage(),
      ),
      GoRoute(
        path: '/recipes/:alphabet',
        builder: (context, state) {
          final alphabet = state.pathParameters['alphabet']!;
          return RecipesListPage(alphabet: alphabet);
        },
      )
    ],
  );
});
