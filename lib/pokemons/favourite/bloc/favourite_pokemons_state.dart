part of 'favourite_pokemons_bloc.dart';

sealed class FavouritePokemonsState extends Equatable {
  const FavouritePokemonsState();
  
  @override
  List<Object> get props => [];
}

final class FavouritePokemonsInitial extends FavouritePokemonsState {}
