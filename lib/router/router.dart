import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_flutter_bloc/main_screen.dart';
import 'package:poke_flutter_bloc/pokemons/detail_pokemon_screen.dart';
import 'package:poke_flutter_bloc/router/router_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (_, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/detail/:name',
      name: 'detail',
      pageBuilder: (context, state) {
        Parms params = state.extra as Parms;
        return CustomTransitionPage(
          key: state.pageKey,
          child: DetailPokemonScreen(
            heroPrefix: params.heroPrefix,
            pokemon: params.pokemon,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
