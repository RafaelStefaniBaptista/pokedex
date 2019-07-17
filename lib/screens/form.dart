import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  static const String routeName = "/form";

  FormPage({Key key}) : super(key: key);

  @override
  _FormPage createState() => _FormPage();
}

class _FormPage extends State<FormPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _textEditingController = TextEditingController();

  void initState() {
    super.initState();
  }

  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // AppBar
      appBar: AppBar(
        // Title
        title: Text("Create your Pokemon"),
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
                  controller: _textEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: 'Enter the pokemon name',
                      hintStyle: TextStyle(
                          color: Colors.white
                      )
                  )
              ),
              // Icon Button
              RaisedButton(
                child: Text("Create Pokemon"),
                // Execute when pressed
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text(_textEditingController.text),
                  ));
                  //Navigator.pop(context);
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