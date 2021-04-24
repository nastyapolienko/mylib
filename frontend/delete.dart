import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fetchlist/book_service.dart';


class DeleteBook extends StatelessWidget {

  final Book book;
  final String token;
  DeleteBook(this.book, this.token);


  Future<Book> _futureBook;

  @override
  void initState() {
    _futureBook = fetchBook(book.bid, token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delete Data'),
        ),
        body: Center(
          child: FutureBuilder<Book>(
            future: _futureBook,
            builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${book?.bookname ?? 'Deleted'}'),
                      RaisedButton(
                        child: Text('Delete Book'),
                        onPressed: () {
                            _futureBook = deleteBook(book.bid, token);
                            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                        },
                      ),
                    ],
                  );


              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
