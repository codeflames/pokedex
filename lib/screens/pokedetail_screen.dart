import 'package:flutter/material.dart';
import 'package:pokedex_app/network/apicalls.dart';
import 'package:pokedex_app/network/poke_detail_api.dart';
import 'package:pokedex_app/network/pokemon_description.dart';

class PokeDetail extends StatefulWidget {
  final String url;
  final String name;

  const PokeDetail({Key key, this.url, this.name}) : super(key: key);

  @override
  _PokeDetailState createState() => _PokeDetailState();
}

class _PokeDetailState extends State<PokeDetail> {
  Future<PokeDetailApi> pokeDetails;
  Future<PokeMonDescription> pokeDescription;

  @override
  void initState() {
    super.initState();
    pokeDetails = pokedetail.fetchPokeDetails(widget.url);
    pokeDescription = pokedetail.fetchPokeMonDescription(
        widget.url.substring(widget.url.indexOf("n/") + 2));
  }

  final pokedetail = new ApiCalls();

  @override
  Widget build(BuildContext context) {
    List<Widget> typesFilter(List<Types> snappy) {
      List<Widget> roww = [];
      for (var i = 0; i < snappy.length; i++) {
        if (i < snappy.length) {
          roww.add(FilterChip(
              backgroundColor: Colors.green[300],
              label: Text(
                snappy[i].type.name,
              ),
              onSelected: (b) {}));
        }
      }
      return roww;
    }

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text(widget.name.substring(0, 1).toUpperCase() +
            widget.name.substring(1)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.wait([pokeDetails, pokeDescription]),
        //pokedetail.fetchPokeDetails(args.url),
        builder: (ctx, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Center(
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                snapshot.data[0].name
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    snapshot.data[0].name
                                        .substring(1)
                                        .toLowerCase(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text('Height : ${snapshot.data[0].height} m'),
                          Text('Weight : ${snapshot.data[0].weight} kg'),
                          Column(
                            children: <Widget>[
                              Text(
                                'Types',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ...typesFilter(snapshot.data[0].types),
                                    ]),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Text(snapshot
                                    .data[1].flavorTextEntries[0].flavorText
                                    .replaceAll("\n", " ")
                                    .replaceAll("\f", "")),
                              ),
                            ],
                          ),
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
                      snapshot.data[0].sprites.frontDefault,
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
