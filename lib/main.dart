import 'package:flutter/material.dart';
import 'package:pokedex/screens/list.dart';
import 'package:pokedex/screens/form.dart';

void main() {
  runApp(new MaterialApp(
    home: new ListPage(), // home has implicit route set at '/'
    // Setup routes
    routes: <String, WidgetBuilder>{
      // Set named routes
      FormPage.routeName: (BuildContext context) => new FormPage(),
    },
  ));
}
