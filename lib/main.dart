import 'package:flutter/material.dart';
import 'package:pokedex_app/poke_home.dart';
import 'package:pokedex_app/pokedetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokeHome(),
      routes: {
        PokeDetail.routeName: (context) => PokeDetail(),
      },
    );
  }
}
