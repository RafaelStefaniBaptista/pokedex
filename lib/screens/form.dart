import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  static const String routeName = "/form";

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        // Title
        title: Text("Home Page"),
        // App Bar background color
        backgroundColor: Colors.red[800],
      ),
      // Body
      body: Container(
        // Center the content
        child: Center(
          child: Column(
            // Center content in the column
            mainAxisAlignment: MainAxisAlignment.center,
            // add children to the column
            children: <Widget>[
              // Text
              Text(
                "Name",
                // Setting the style for the Text
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
            TextFormField(
              controller: textEditingController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter the pokemon name',
                hintStyle: TextStyle(
                    color: Colors.white
                )
              )
            ),
              // Icon Button
              RaisedButton(
                child: Text("Create Pokeemon"),
                // Execute when pressed
                onPressed: () {
                  
                  //Navigator.of(context).pushNamed(AboutPage.routeName);
                },
                textColor: Colors.white,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}
