import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/screens/camera.dart';
import 'package:pokedex/screens/list.dart';
import 'package:pokedex/screens/form.dart';

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(new MaterialApp(
    home: new ListPage(), // home has implicit route set at '/'
    // Setup routes
    routes: <String, WidgetBuilder>{
      // Set named routes
      TakePictureScreen.routeName: (BuildContext context) => new TakePictureScreen(camera: firstCamera),
      FormPage.routeName: (BuildContext context) => new FormPage(),
    },
  ));
}
