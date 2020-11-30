import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/pokeapi.dart';
import 'package:pokedex_app/pokedetail.dart';
import 'package:pokedex_app/pokemon.dart';

class PokeHome extends StatefulWidget {
  @override
  _PokeHomeState createState() => _PokeHomeState();
}

class _PokeHomeState extends State<PokeHome> {
  String url = "https://pokeapi.co/api/v2/pokemon?limit=151";
  Future<List<Results>> pokemons;

  Future<List<Results>> getPokemons() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final result = Pokemon.fromJson(jsonDecode(response.body));
      return result.results;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pokemons = getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POkeMons'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: pokemons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (
                  ctx,
                  index,
                ) =>
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        PokeDetail.routeName,
                        arguments: PokeApi(
                            name: snapshot.data[index].name,
                            url: snapshot.data[index].url),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.navigate_next)
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
