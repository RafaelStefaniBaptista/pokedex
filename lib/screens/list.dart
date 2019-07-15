import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('This will be a PokeDex'),
        ),
      ),
      body: backToTheFuture()
    );
  }
}

backToTheFuture() {
  return new FutureBuilder(
    future: getPokemonListData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return new Text('loading...');
        default:
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            return createListView(context, snapshot);
      }
    },
  );
}


class PokemonCard extends StatelessWidget {
  final String name;
  final String img;

  PokemonCard(this.name, this.img);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 140,
      width: 50,
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
              offset: new Offset(0, 0), spreadRadius: 0.2, blurRadius: 0.2),
        ],
      ),
      child: new PokemonCardData(name, img),
    );
  }
}

class PokemonCardData extends StatelessWidget {
  final String name;
  final String img;

  PokemonCardData(this.name, this.img);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(name),
        Image.network(
          img,
          height: 100,
        ),
      ],
    );
  }
}

class PokemonCardRow extends StatelessWidget {
  final List pokemon;

  PokemonCardRow(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new PokemonCard(pokemon[0],
            'https://static.pokemonpets.com/images/monsters-images-300-300/5-Charmeleon.png'),
        PokemonCard(pokemon[0],
            'https://static.pokemonpets.com/images/monsters-images-300-300/5-Charmeleon.png'),
      ],
    );
  }
}

class Pokemon {
  final String name;
  final String url;

  Pokemon(this.name, this.url);
}

class PokemonList {
  final List<Pokemon> pokemonList;

  PokemonList({this.pokemonList});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      pokemonList: (json['results'] as List)
          .map((pokemon) => new Pokemon(pokemon['name'], pokemon['url']))
          .toList(),
    );
  }
}

Future<PokemonList> getPokemonListData() async {
  final response = await http.get('https://pokeapi.co/api/v2/pokemon/');

  if (response.statusCode == 200) {
    return PokemonList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokemons from the API');
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Pokemon> pokemonList = snapshot.data.pokemonList;

  return new ListView.builder(
    itemCount: pokemonList.length,
    itemBuilder: (BuildContext context, int index) {
      return new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(pokemonList[index].name),
          ),
          new Divider(height: 2.0,),
        ],
      );
    },
  );
}