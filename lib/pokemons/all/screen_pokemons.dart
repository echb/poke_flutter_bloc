import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:poke_flutter_bloc/pokemons/all/bloc/pokemons_bloc.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';
import 'package:poke_flutter_bloc/pokemons/ui/poke_card.dart';
import 'package:poke_flutter_bloc/router/router_model.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final counterBloc = BlocProvider.of<PokemonsBloc>(context, listen: false);
    final passwordFocusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        passwordFocusNode.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Pokemon> items = state.searchPokemons;

          return CustomScrollView(
            controller: counterBloc.loadMoreController,
            slivers: <Widget>[
              SliverAppBar(
                toolbarHeight: 80,
                floating: true,
                elevation: 0,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.black12,
                                child: TextField(
                                  focusNode: passwordFocusNode,
                                  onChanged: (value) {
                                    counterBloc.add(OnSearch(value));
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    labelText: 'Search',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: DropdownButton(
                                hint: const Text('Select a type'),
                                value: state.selectedType?.type,
                                items: state.types
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.type,
                                        child: Text('${e.type}'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  counterBloc.add(OnSelectedType(
                                      Type(type: value.toString())));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                actions: const [
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: items.length,
                  (_, i) {
                    Pokemon pokemon = items.elementAt(i);
                    return PokeCard(
                      heroPrefix: counterBloc.heroKey,
                      name: pokemon.name!,
                      type: pokemon.types?.elementAt(0)?.type ?? '',
                      onTap: () {
                        passwordFocusNode.unfocus();
                        FocusScope.of(context).unfocus();

                        Future.microtask(() {
                          if (!context.mounted) return;
                          GoRouter.of(context).pushNamed(
                            'detail',
                            pathParameters: {
                              'name': pokemon.name!,
                            },
                            extra: Parms(
                              heroPrefix: counterBloc.heroKey,
                              pokemon: pokemon,
                            ),
                          );
                        });
                      },
                    );
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: .7,
                ),
              ),
              if (!state.reachEnd && state.loadingMore)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              if (state.reachEnd)
                const SliverToBoxAdapter(
                  child: Text(
                    'End of pokemons',
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
