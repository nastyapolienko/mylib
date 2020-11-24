import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fetchlist/book_service.dart';

class UpdateBook extends StatelessWidget {

  final Book book;
  final String token;
  UpdateBook(this.book, this.token);

   TextEditingController _controller1 = TextEditingController();
   TextEditingController _controller2 = TextEditingController();

  Future<Book> _futureBook;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Book>(
            future: _futureBook,
            builder: (BuildContext context, snapshot) {

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(book.bookname),
                      TextFormField(
                        controller: _controller1 = TextEditingController(text: book.bookname),
                      ),
                      TextFormField(
                        controller: _controller2 = TextEditingController(text: book.year),
                      ),
                      RaisedButton(
                        child: Text('Update Book'),
                        onPressed: () {
                            _futureBook = updateBook(book.bid, _controller1.text, _controller2.text, token);
                            Navigator.canPop(context);

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
