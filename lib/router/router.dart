import 'package:go_router/go_router.dart';
import 'package:poke_flutter_bloc/main_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (_, state) => const MainScreen(),
    ),
  ],
);
