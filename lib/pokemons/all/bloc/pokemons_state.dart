part of 'pokemons_bloc.dart';

class PokemonsState extends Equatable {
  final bool loading;
  final bool loadingMore;
  final List<Pokemon> pokemons;
  final int offset;
  final int total = 50;
  final int size = 10;
  final bool reachEnd;

  final String? search;
  final List<Pokemon> searchPokemons;
  final List<Type> types;
  final Type? selectedType;

  const PokemonsState({
    required this.pokemons,
    required this.searchPokemons,
    required this.loading,
    required this.loadingMore,
    required this.offset,
    this.reachEnd = false,
    this.search = '',
    this.types = const [],
    this.selectedType,
  });

  copyWith({
    List<Pokemon>? pokemons,
    List<Pokemon>? searchPokemons,
    bool? loading,
    bool? loadingMore,
    int? offset,
    bool? reachEnd,
    String? search,
    List<Type>? types,
    Type? selectedType,
  }) =>
      PokemonsState(
        pokemons: pokemons ?? this.pokemons,
        searchPokemons: searchPokemons ?? this.searchPokemons,
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        offset: offset ?? this.offset,
        reachEnd: reachEnd ?? this.reachEnd,
        search: search ?? this.search,
        types: types ?? this.types,
        selectedType: selectedType ?? this.selectedType,
      );

  @override
  List<Object?> get props => [
        size,
        total,
        loading,
        loadingMore,
        pokemons,
        offset,
        reachEnd,
        search,
        searchPokemons,
        types,
        selectedType,
      ];
}
