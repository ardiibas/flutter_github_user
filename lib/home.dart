import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _HomePageState();
    }
}

class _HomePageState extends State<HomePage>{
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text("Github User List"),
        ),
        body: Center(
          child: Text("Hai there!"),
        ),
      );
    }
}