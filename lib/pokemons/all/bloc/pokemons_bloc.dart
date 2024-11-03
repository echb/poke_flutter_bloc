import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:poke_flutter_bloc/pokemons/api_pokemon.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';
import 'package:poke_flutter_bloc/pokemons/models/model_responses.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final PokeApiController _api = PokeApiController();
  final String heroKey = 'home';
  ScrollController loadMoreController = ScrollController();

  PokemonsBloc()
      : super(
          const PokemonsState(
            offset: 0,
            loadingMore: false,
            loading: false,
            pokemons: [],
            searchPokemons: [],
          ),
        ) {
    on<OnInit>((event, emit) async {
      emit(state.copyWith(loading: true));

      _api.getTypes().then((e) {
        if (e.error != null) {
          // EMIT ERROR ON GLOBAL ALERT

          return;
        }

        emit(state.copyWith(types: [
          Type(type: 'All'),
          ...e.res!,
        ]));
      });

      List<CustomResponse<Pokemon>> response =
          await Future.wait(List.generate(10, (i) => _api.getPokemon(i + 1)));

      List<Pokemon> res = response.map((e) {
        if (e.error != null) {
          // EMIT ERROR ON GLOBAL ALERT
        }

        return e.res as Pokemon;
      }).toList();
      emit(state.copyWith(
        pokemons: res,
        loading: false,
        searchPokemons: res,
      ));
    });

    on<OnGetMore>((event, emit) async {
      if (state.reachEnd) return;

      emit(
          state.copyWith(offset: state.offset + state.size, loadingMore: true));

      List<CustomResponse<Pokemon>> response = await Future.wait(List.generate(
          state.size, (i) => _api.getPokemon(i + state.offset + 1)));

      List<Pokemon> res = response.map((e) => e.res as Pokemon).toList();
      // if (res.error != null) return;

      List<Pokemon>? results = _filter(state.selectedType, state.search!);

      if (results == null) {
        emit(state.copyWith(
          loadingMore: false,
          reachEnd: state.offset == 40,
          pokemons: [...state.pokemons, ...res],
          searchPokemons: [...state.pokemons, ...res],
        ));
        return;
      }

      emit(state.copyWith(
        loadingMore: false,
        reachEnd: state.offset == 40,
        pokemons: [...state.pokemons, ...res],
        searchPokemons: results,
      ));
    });

    on<OnSearch>((event, emit) async {
      List<Pokemon>? results = _filter(state.selectedType, event.search);

      if (results == null) {
        emit(state.copyWith(
          search: event.search,
          searchPokemons: state.pokemons,
        ));
        return;
      }

      emit(state.copyWith(
        search: event.search,
        searchPokemons: results,
      ));
    });

    on<OnSelectedType>((event, emit) async {
      List<Pokemon>? results = _filter(event.selectedType, state.search!);

      if (results == null) {
        emit(state.copyWith(
          selectedType: Type(type: event.selectedType?.type),
          searchPokemons: state.pokemons,
        ));
        return;
      }

      emit(state.copyWith(
        selectedType: Type(type: event.selectedType?.type),
        searchPokemons: results,
      ));
    });

    _init();
  }

  _init() async {
    add(OnInit());
    loadMoreController.addListener(() {
      if (state.reachEnd) return;

      if (loadMoreController.position.maxScrollExtent ==
          loadMoreController.offset) {
        add(OnGetMore());
      }
    });
  }

  List<Pokemon>? _filter(Type? type, String search) {
    List<Pokemon>? results;

    if ((type?.type == null || type?.type == 'All') && search == '') {
      return null;
    }

    if ((type?.type != null && type?.type != 'All') && search.isNotEmpty) {
      results = state.pokemons
          .where((e) =>
              e.types!.any((e) => e!.type == type?.type) &&
              e.name!.contains(search))
          .toList();
    } else if (search.isNotEmpty) {
      results = state.pokemons.where((e) => e.name!.contains(search)).toList();
    } else {
      results = state.pokemons
          .where((e) => e.types!.any((e) => e!.type == type?.type))
          .toList();
    }

    return results;
  }
}
