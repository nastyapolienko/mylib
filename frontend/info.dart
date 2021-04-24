import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fetchlist/update.dart';
import 'package:fetchlist/book_service.dart';
import 'package:fetchlist/delete.dart';

class DetailPage extends StatelessWidget {

  final Book book;
  final String token;
  DetailPage(this.book, this.token);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book.bookname),
        ),

        floatingActionButton: Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left:31),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => DeleteBook(book, token))
                    );
                  Navigator.canPop(context);
                  },
                  child: const Icon(Icons.delete),
                ),
              ),),
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: (){
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => UpdateBook(book, token))
                    );
                    Navigator.canPop(context);
                  },
                  child: Icon(Icons.edit),
                ),
              )
            ]
        ),


        body: Center(

          child: FutureBuilder<Book>(

            future: fetchBook(book.bid, token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.bookname + "\n" + snapshot.data.year);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }


              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}



