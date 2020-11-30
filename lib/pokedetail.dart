import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex_app/poke_detail_api.dart';
import 'package:pokedex_app/pokeapi.dart';
import 'package:http/http.dart' as http;

class PokeDetail extends StatefulWidget {
  static const routeName = '/pokeDetailRoute';
  @override
  _PokeDetailState createState() => _PokeDetailState();
}

class _PokeDetailState extends State<PokeDetail> {
  @override
  Widget build(BuildContext context) {
    final PokeApi args = ModalRoute.of(context).settings.arguments;
    final url = args.url;

    Future<PokeDetailApi> fetchPokeDetails() async {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = PokeDetailApi.fromJson(jsonDecode(response.body));
        //print(result.types[0].type.name);
        return result;
      }
      return null;
    }

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text(
            args.name.substring(0, 1).toUpperCase() + args.name.substring(1)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchPokeDetails(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              snapshot.data.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('Height : ${snapshot.data.height}'),
                          Text('Weight : ${snapshot.data.weight}'),
                          Column(
                            children: <Widget>[
                              Text(
                                'Types',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 100,
                                width: 150,
                                alignment: Alignment.center,
                                child: ListView.builder(
                                    itemCount: snapshot.data.types.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FilterChip(
                                              backgroundColor:
                                                  Colors.green[300],
                                              label: Text(
                                                snapshot.data.types[index].type
                                                    .name,
                                              ),
                                              onSelected: (b) {}),
                                        )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image.network(
                      snapshot.data.sprites.frontDefault,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
