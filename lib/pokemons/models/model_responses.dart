import 'dart:convert';

import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';

class CustomResponse<T> {
  final dynamic error;
  final T? res;
  CustomResponse(this.error, this.res);
}

class TypesResult {
  List<Type>? types;
  TypesResult({
    this.types,
  });

  factory TypesResult.fromJson(String str) =>
      TypesResult.fromMap(json.decode(str));

  factory TypesResult.fromMap(Map<String, dynamic> json) => TypesResult(
        types:
            List<Type>.from(json["results"]!.map((x) => Type.fromTypesMap(x))),
      );
}

class PokemonResult {
  List<Pokemon>? pokemons;
  PokemonResult({
    this.pokemons,
  });

  factory PokemonResult.fromJson(String str) =>
      PokemonResult.fromMap(json.decode(str));

  factory PokemonResult.fromMap(Map<String, dynamic> json) => PokemonResult(
        pokemons:
            List<Pokemon>.from(json["results"]!.map((x) => Pokemon.fromMap(x))),
      );
}
