import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fetchlist/login_screen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MyLib',
      theme: new ThemeData(
          primarySwatch: Colors.purple
      ),
      home: new LoginPage(),
    );
  }
}

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
  await client.get('http://192.168.0.106:8080/users');
  return compute(parseUsers, response.body);
}


List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class User {
  int uid;
   String email;
   String pass;

  User({this.uid, this.email, this.pass});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as int,
      email: json['email'] as String,
      pass: json['pass'] as String,
    );
  }
}

Future<User> createUser(String email, pass) async {
  final http.Response response = await http.post(
    'http://192.168.0.106:8080/users',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'pass' : pass,
    }),
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create a user.');
  }
}

class UsersList extends StatelessWidget {
  UsersList({Key key, this.users}) : super(key: key);
  final List<User> users;
  User user;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(users[index].email),
        );
      },
    );
  }
}
