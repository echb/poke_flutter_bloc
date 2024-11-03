part of 'favourite_pokemons_bloc.dart';

final class FavouritePokemonsState extends Equatable {
  final Set<Pokemon> favourite;

  const FavouritePokemonsState({
    this.favourite = const {},
  });

  copyWith({
    Set<Pokemon>? favourite,
  }) =>
      FavouritePokemonsState(
        favourite: favourite ?? this.favourite,
      );

  @override
  List<Object> get props => [
        favourite,
      ];
}
