import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fetchlist/info.dart';
import 'package:fetchlist/main.dart';
import 'package:fetchlist/create.dart';
import 'package:fetchlist/jwt_service.dart';
import 'package:fetchlist/book_service.dart';


class MyHomePage extends StatelessWidget {
  final String token;

  MyHomePage(this.token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Books"),
        ),
        body: FutureBuilder<List<Book>>(
          future: fetchBooks(http.Client(), token),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                ? BooksList(snapshot.data, token)
                : Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => CreateBook(getUserID(token), token))
            );
          },
          child: const Icon(Icons.add),
        )
    );
  }
}


class BooksList extends StatelessWidget {
  BooksList(this.books, this.token);
  final List<Book> books;
  final String token;
  Book book;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(books[index].bookname),
            onTap:(){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => DetailPage(books[index], token))
              );
            }
        );
      },
    );
  }
}

