import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/all/bloc/pokemons_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/favourite/bloc/favourite_pokemons_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/local.dart';
import 'package:poke_flutter_bloc/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Local().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PokemonsBloc(),
        ),
        BlocProvider(
          create: (context) => FavouritePokemonsBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Pokemons App',
        routerConfig: router,
      ),
    );
  }
}
