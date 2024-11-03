import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:poke_flutter_bloc/pokemons/favourite/bloc/favourite_pokemons_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';
import 'package:poke_flutter_bloc/pokemons/ui/poke_card.dart';
import 'package:poke_flutter_bloc/router/router_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouritePokemonsBloc>(context, listen: false);

    return BlocBuilder<FavouritePokemonsBloc, FavouritePokemonsState>(
      builder: (context, state) {
        Set<Pokemon> items = state.favourite;

        return CustomScrollView(
          slivers: [
            SliverGrid.builder(
              itemCount: state.favourite.length,
              itemBuilder: (context, index) {
                Pokemon pokemon = items.elementAt(index);

                return PokeCard(
                  heroPrefix: bloc.heroKey,
                  name: pokemon.name!,
                  type: pokemon.types?.elementAt(0)?.type ?? '',
                  onTap: () {
                    Future.microtask(() {
                      if (!context.mounted) return;
                      GoRouter.of(context).pushNamed(
                        'detail',
                        pathParameters: {
                          'name': pokemon.name!,
                        },
                        extra: Parms(
                          heroPrefix: bloc.heroKey,
                          pokemon: pokemon,
                        ),
                      );
                    });
                  },
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 5,
                childAspectRatio: .7,
              ),
            ),
          ],
        );
      },
    );
  }
}
