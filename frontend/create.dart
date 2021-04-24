import 'dart:async';
import 'package:fetchlist/jwt_service.dart';
import 'package:flutter/material.dart';
import 'package:fetchlist/book_service.dart';

class CreateBook extends StatelessWidget {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<Book> _futureBook;

  final int uid;
  final String token;

  CreateBook(this.uid, this.token);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Book Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Creating a Book'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureBook == null)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller1,
                decoration: InputDecoration(hintText: 'Enter Title'),
              ),
              TextField(
                controller: _controller2,
                decoration: InputDecoration(hintText: 'Enter Year'),
              ),
              RaisedButton(
                child: Text('Add book'),
                onPressed: () {
                  print(getUserID(token));
                  _futureBook = createBook(_controller1.text, _controller2.text, token);
                  Navigator.pop(context);
                },
              ),
            ],
          )
              : FutureBuilder<Book>(
            future: _futureBook,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.bookname);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}


