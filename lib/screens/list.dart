import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/string.dart';

import 'camera.dart';
import 'form.dart';

class ListPage extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        centerTitle: true,
        leading: new FlatButton(
          onPressed: () => {cameraClick(context)},
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
        title: SizedBox(
          height: 35.0,
          child: Image.asset("assets/images/logo.png")
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.mic),
          )
        ],
      ),
      backgroundColor: Colors.red,
      body: Container(
          child: Column(
            // Center content in the column
            mainAxisAlignment: MainAxisAlignment.center,
            // add children to the column
            children: <Widget>[
               Expanded(
                   child: backToTheFuture()
              ),
              RaisedButton(
                child: Text("Create Pokemon"),
                // Execute when pressed
                onPressed: () {
                  Navigator.of(context).pushNamed(FormPage.routeName);
                },
                textColor: Colors.white,
                color: Colors.blue,
              )
            ]
        ),
      ),
    );
  }

  cameraClick(BuildContext context) {
    Navigator.of(context).pushNamed(TakePictureScreen.routeName);
  }
}

backToTheFuture() {
  return new FutureBuilder(
    future: getPokemonListData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return new Text('Loading...');
        default:
          if (snapshot.hasError)
            return new Text(snapshot.error.toString());
          else
            return createListView(context, snapshot);
      }
    },
  );
}

List<Pokemon> getPokemonListFromJson(Map<String, dynamic> json) {
  return (json['results'] as List)
      .map((pokemonJson) => new Pokemon(name: firstUpperCase(pokemonJson['name']), url: pokemonJson['url']))
      .toList();
}

Future<List<Pokemon>> getPokemonListData() async {
  final response = await http.get('https://pokeapi.co/api/v2/pokemon/');

  if (response.statusCode == 200) {
    return getPokemonListFromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokemons from the API');
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Pokemon> pokemonList = snapshot.data;

  return GridView.count(
    crossAxisCount: 2,
    children: pokemonList
        .map((poke) =>
        Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokeDetail(
                          pokemon: poke,
                        )
                    )
                );
              },
              child: Hero(
                tag: poke.name,
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 10, top: 15),
                            child:
                            Transform.scale(
                                scale: 4.2,
                                child:
                                Container(
                                  height: 120,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                                          )
                                      )
                                  ),
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              poke.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        )
                      ],),
                    ],
                  ),
                ),
              ),
            )
        )
    )
        .toList(),
  );



//  return new ListView.builder(
//    itemCount: pokemonList.length,
//    itemBuilder: (BuildContext context, int index) {
//      return new Column(
//        children: <Widget>[
//          new ListTile(
//            title: new Text(
//              firstUpperCase(pokemonList[index].name),
//                style: TextStyle(color: Colors.white),
//            ),
//          ),
//          new Divider(height: 2.0,),
//        ],
//      );
//    },
//  );
}

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.075,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Text(
                pokemon.name,
                style:
                TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text("Height: 96"),
              Text("Weight: 96"),
              Text(
                "Types",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["gaymer"]
                    .map((t) => FilterChip(
                    backgroundColor: Colors.amber[600],
                    label: Text(
                      t,
                      style: TextStyle(color: Colors.white),
                    ),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["tureba"]
                    .map((t) => FilterChip(
                    backgroundColor: Colors.cyan,
                    label: Text(
                      t,
                      style: TextStyle(color: Colors.white),
                    ),
                    onSelected: (b) {}))
                    .toList(),
              ),
              Text("Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["sua mãe"]
                    .map((n) => FilterChip(
                    backgroundColor: Colors.green,
                    label: Text(n,
                        style: TextStyle(color: Colors.white)),
                    onSelected: (b) {}))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: "assets/images/loader.gif",
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
//                      image: AssetImage("assets/images/loader.gif")
                  )
              ),
            )),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}
