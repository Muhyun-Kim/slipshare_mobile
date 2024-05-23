import 'package:go_router/go_router.dart';
import 'package:slipshare_mobile/views/home_page.dart';
import 'package:slipshare_mobile/views/login_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(
        title: 'hello',
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
