part of 'pokemons_bloc.dart';

sealed class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

class OnInit extends PokemonsEvent {}

class OnGetMore extends PokemonsEvent {}

class OnReachEnd extends PokemonsEvent {}

class OnSearch extends PokemonsEvent {
  final String search;
  const OnSearch(this.search);
}

class OnSelectedType extends PokemonsEvent {
  final Type? selectedType;
  const OnSelectedType(this.selectedType);
}
