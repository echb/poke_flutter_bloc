import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_flutter_bloc/extensions.dart';
import 'package:poke_flutter_bloc/pokemons/favourite/bloc/favourite_pokemons_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';

class DetailPokemonScreen extends StatelessWidget {
  final Pokemon pokemon;
  final String heroPrefix;

  const DetailPokemonScreen({
    super.key,
    required this.pokemon,
    required this.heroPrefix,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouritePokemonsBloc>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<FavouritePokemonsBloc, FavouritePokemonsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color.fromARGB(210, 219, 219, 219),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                      Text(
                        pokemon.name!.capitalize(),
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('Link copied'),
                                  showCloseIcon: true,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.share,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (state.favourite.contains(pokemon.name)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Removed'),
                                    showCloseIcon: true,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Saved to favourites'),
                                    showCloseIcon: true,
                                  ),
                                );
                              }
                              bloc.add(OnToggleFavourite(pokemon));
                            },
                            icon: Icon(
                              state.favourite
                                      .where(
                                          (element) => element.id == pokemon.id)
                                      .isEmpty
                                  ? Icons.favorite_border_rounded
                                  : Icons.favorite,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: '${heroPrefix}_${pokemon.name}',
                  child: Image.network(
                    'https://img.pokemondb.net/artwork/${pokemon.name}.jpg',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    height: 300,
                    width: double.maxFinite,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'Types',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pokemon.types?.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 16 : 0,
                          right: 16,
                        ),
                        child: Chip(
                          side: BorderSide.none,
                          backgroundColor: Colors.black,
                          label: Text(
                            pokemon.types
                                    ?.elementAt(index)
                                    ?.type
                                    ?.capitalize() ??
                                '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'Stats',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(
                      5,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: pokemon.stats!.map((e) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e!.name!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${e.baseStat}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
