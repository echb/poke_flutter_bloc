part of 'favourite_pokemons_bloc.dart';

sealed class FavouritePokemonsEvent extends Equatable {
  const FavouritePokemonsEvent();

  @override
  List<Object> get props => [];
}

class OnInit extends FavouritePokemonsEvent {}

class OnToggleFavourite extends FavouritePokemonsEvent {
  final Pokemon favourite;
  const OnToggleFavourite(this.favourite);
}
