import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../pojo/user.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Github User List"),
      ),
      body: Container(
        child: FutureBuilder<List<User>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data[index].name,
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      new Divider()
                    ],
                  );
                },
              );
            } else if (snapshot.error) {
              return Text("${snapshot.error}");
            }

            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<List<User>> fetchData() async {
  final respone = await http.get('https://api.github.com/users');
  print(respone.body);
  List responeJSON = json.decode(respone.body.toLowerCase());
  List<User> userList = createUserList(responeJSON);
  return userList;
}

List<User> createUserList(List data) {
  List<User> list = new List();
  for (int i = 0; i < data.length; i++) {
    String title = data[i]["login"];
    int id = data[i]["id"];
    User user = new User(name: title, id: id);
    list.add(user);
  }
  return list;
}
