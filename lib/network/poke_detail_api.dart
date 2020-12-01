class PokeDetailApi {
  int height;

  int id;

  String name;

  Sprites sprites;

  int weight;
  List<Types> types;

  PokeDetailApi({
    this.height,
    this.id,
    this.name,
    this.sprites,
    this.weight,
    this.types,
  });

  PokeDetailApi.fromJson(Map<String, dynamic> json) {
    height = json['height'];

    id = json['id'];

    name = json['name'];

    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;

    weight = json['weight'];

    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['height'] = this.height;

    data['id'] = this.id;

    data['name'] = this.name;

    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }

    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }

    data['weight'] = this.weight;
    return data;
  }
}

class Sprites {
  String frontDefault;

  Sprites({
    this.frontDefault,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_default'] = this.frontDefault;

    return data;
  }
}

class Types {
  int slot;
  Ability type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Ability.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class Ability {
  String name;
  String url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
