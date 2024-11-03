import 'package:poke_flutter_bloc/pokemons/models/model_pokemon.dart';

class Parms {
  String heroPrefix;
  Pokemon pokemon;

  Parms({
    required this.heroPrefix,
    required this.pokemon,
  });

  factory Parms.fromMap(Map<String, dynamic> json) => Parms(
        pokemon: json["pokemon"],
        heroPrefix: json["heroPrefix"],
      );
}
