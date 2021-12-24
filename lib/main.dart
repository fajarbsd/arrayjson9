import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List? data;

  get JSON => null;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    setState(() {
      data = jsonDecode(response.body);
    });

    print(data![1]["title"]);

    return "Success!";
  }

  newMethod(http.Response response) => JSON.decode(response.body);

  @override
  void initState() {
    super.initState();
    setState(() {});
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listviews"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: data == null ? 0 : data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(
                      data![index]["title"],
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    Text(data![index]["body"]),
                  ])));
        },
      ),
    );
  }
}
