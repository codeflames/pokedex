import 'package:flutter/material.dart';
import 'package:pokedex_app/screens/poke_home_screen.dart';
import 'package:pokedex_app/screens/pokedetail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokeHome(),
      // routes: {
      //   PokeDetail.routeName: (context) => PokeDetail(),
      // },
    );
  }
}
