import 'package:flutter/material.dart';
import 'package:pokedex_app/network/apicalls.dart';
import 'package:pokedex_app/screens/pokedetail_screen.dart';
import 'package:pokedex_app/network/pokemon.dart';
import 'package:search_page/search_page.dart';

class PokeHome extends StatefulWidget {
  @override
  _PokeHomeState createState() => _PokeHomeState();
}

class _PokeHomeState extends State<PokeHome> {
  //to call the getPokemon api function
  //from the ApiCalls class in the apicalls.dart file
  final pokes = new ApiCalls();
  Future<List<Results>> pokemons;

  //to store the list of pokemons
  List<Results> pokessList;

  @override
  void initState() {
    super.initState();
    pokessList = pokes.pokeList;
    pokemons = pokes.getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POkéMons',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: pokemons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: pokessList.length,
                itemBuilder: (
                  ctx,
                  index,
                ) =>
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PokeDetail(
                                url: pokessList[index].url,
                                name: pokessList[index].name,
                              ))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              pokessList[index]
                                      .name
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  pokessList[index]
                                      .name
                                      .substring(1)
                                      .toLowerCase(),
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
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Search people',
        onPressed: () => showSearch(
            context: context,
            // ignore: missing_required_param
            delegate: SearchPage<Results>(
                items: pokessList,
                searchLabel: 'Search pokemons',
                suggestion: Center(
                  child: Text('Filter pokemon by name'),
                ),
                failure: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/image/poke_not_found.png'),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          'No pokemon found :(',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                filter: (result) => [
                      result.name,
                      result.url,
                    ],
                builder: (result) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PokeDetail(
                                url: result.url,
                                name: result.name,
                              ))),
                      child: ListTile(
                        title: Text(
                          result.name.substring(0, 1).toUpperCase() +
                              result.name.substring(1).toLowerCase(),
                        ),
                      ),
                    ))),
        icon: Icon(Icons.search),
        label: Text('Search'),
      ),
    );
  }
}
