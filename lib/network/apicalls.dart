import 'dart:convert';

import 'package:pokedex_app/network/poke_detail_api.dart';
import 'package:pokedex_app/network/pokemon.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  List<Results> pokeList = [];

  List<Results> get _pokeList {
    return pokeList;
  }

  Future<List<Results>> getPokemons() async {
    const String url = "https://pokeapi.co/api/v2/pokemon?limit=151";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final result = Pokemon.fromJson(jsonDecode(response.body));
      pokeList.addAll(result.results);
      return result.results;
    }
    return null;
  }

  Future<PokeDetailApi> fetchPokeDetails(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = PokeDetailApi.fromJson(jsonDecode(response.body));
      //print(result.types[0].type.name);
      return result;
    }
    return null;
  }
}
