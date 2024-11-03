import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/all/bloc/pokemons_bloc.dart';
import 'package:poke_flutter_bloc/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MaterialApp.router(
        title: 'Pokemons App',
        routerConfig: router,
      ),
    );
  }
}
