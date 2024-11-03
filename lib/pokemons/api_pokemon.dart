import 'package:http/http.dart' as http;
import 'package:poke_flutter_bloc/pokemons/models/model_responses.dart';

import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';

class PokeApiController {
  final baseUrl = "https://pokeapi.co/api/v2";

  Future<CustomResponse<Pokemon>> getPokemon(int id) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
      var res = CustomResponse(null, Pokemon.fromJson(response.body));
      return res;
    } catch (e) {
      return CustomResponse(e, null);
    }
  }

  Future<CustomResponse<List<Type>?>> getTypes() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/type'));
      return CustomResponse(null, TypesResult.fromJson(response.body).types);
    } catch (e) {
      return CustomResponse(e, null);
    }
  }
}
