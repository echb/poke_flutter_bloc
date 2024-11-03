import 'dart:convert';

class Pokemon {
  Pokemon({
    this.id,
    this.name,
    this.types,
    this.stats,
  });

  int? id;
  String? name;
  List<Type?>? types;
  List<Stat?>? stats;

  Pokemon copyWith({
    int? id,
    String? name,
    List<Type?>? types,
    List<Stat?>? stats,
  }) =>
      Pokemon(
        id: id ?? this.id,
        name: name ?? this.name,
        types: types ?? this.types,
        stats: stats ?? this.stats,
      );

  factory Pokemon.fromJson(String str) => Pokemon.fromMap(json.decode(str));

  String toJson() => jsonEncode(toMap());

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: json["name"],
        types: json["types"] == null
            ? []
            : List<Type?>.from(json["types"]!.map((x) => Type.fromMap(x))),
        stats: json["stats"] == null
            ? []
            : List<Stat?>.from(json["stats"]!.map((x) => Stat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "types": types?.map((x) => x?.toMap()).toList(),
        "stats": stats?.map((x) => x?.toMap()).toList(),
      };
}

class Type {
  Type({
    this.type,
  });

  String? type;

  Type copyWith({
    String? type,
  }) =>
      Type(
        type: type ?? this.type,
      );

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        type: json["type"]['name'],
      );
  factory Type.fromTypesMap(Map<String, dynamic> json) => Type(
        type: json['name'],
      );

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        "type": {
          "name": type,
        },
      };
}

class Stat {
  Stat({
    this.baseStat,
    this.name,
  });

  int? baseStat;
  String? name;

  Stat copyWith({
    int? baseStat,
    String? name,
  }) =>
      Stat(
        baseStat: baseStat ?? this.baseStat,
        name: name ?? this.name,
      );

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  factory Stat.fromMap(Map<String, dynamic> json) {
    return Stat(
      baseStat: json["base_stat"],
      name: json["stat"]["name"],
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "stat": {
          "name": name,
        },
      };
}
