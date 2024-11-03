import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_flutter_bloc/pokemons/local.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';

part 'favourite_pokemons_event.dart';
part 'favourite_pokemons_state.dart';

class FavouritePokemonsBloc
    extends Bloc<FavouritePokemonsEvent, FavouritePokemonsState> {
  final Local _local = Local();
  final String key = 'favourites';
  final String heroKey = 'fav';

  FavouritePokemonsBloc()
      : super(
          const FavouritePokemonsState(
            favourite: {},
          ),
        ) {
    on<OnInit>((event, emit) {
      emit(state.copyWith(
        favourite:
            _local.getFavourites(key)?.map((e) => Pokemon.fromJson(e)).toSet(),
      ));
    });

    on<OnToggleFavourite>((event, emit) {
      Set<Pokemon> temp = {};

      if (state.favourite.contains(event.favourite)) {
        temp.addAll(state.favourite.where((e) => e.id != event.favourite.id));
      } else {
        temp.addAll({...state.favourite, event.favourite});
      }

      _local.setFavourite(key, temp.map((e) => e.toJson()).toList());
      emit(
        state.copyWith(favourite: temp),
      );
    });

    _init();
  }

  _init() {
    add(OnInit());
  }
}
