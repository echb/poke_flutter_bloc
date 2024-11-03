import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourite_pokemons_event.dart';
part 'favourite_pokemons_state.dart';

class FavouritePokemonsBloc extends Bloc<FavouritePokemonsEvent, FavouritePokemonsState> {
  FavouritePokemonsBloc() : super(FavouritePokemonsInitial()) {
    on<FavouritePokemonsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
