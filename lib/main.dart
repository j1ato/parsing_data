import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// https://jsonplaceholder.typicode.com/user

Future<List> getJSON() async {
  const String apiURL = 'https://jsonplaceholder.typicode.com/users';

  final http.Response response = await http.get(apiURL);

  return json.decode(response.body);
}

Future<void> main() async {
  final List _data = await getJSON();

  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: const Text('JSON Parsing'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.4),
          child: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 3.4,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                      title: Text(
                        "${_data[position]["title"]}",
                        style: TextStyle(
                          fontSize: 17.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("${_data[position]["body"]}"),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(_data[position]['title'][0]),
                      ),
                      onTap: () =>
                          showTapMessage(context, _data[position]['title'])),
                ],
              );
            },
          ),
        )),
  ));
}

void showTapMessage(BuildContext context, String message) {
  final alertDialog = AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Okay'),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
