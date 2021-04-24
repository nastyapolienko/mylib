import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fetchlist/jwt_service.dart';
import 'dart:async';
import 'dart:convert';

class Book {
  final int bid;
  final String bookname;
  final String year;
  final int uid;
  final String status;

  Book({this.bid, this.bookname, this.year, this.uid, this.status});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bid: json['bid'] as int,
      bookname: json['bookname'] as String,
      year: json['year'] as String,
      uid: json['uid'] as int,
      status: json['status'] as String,
    );
  }
}

Future<List<Book>> fetchBooks(http.Client client, String token) async {
  final response =
  await client.get('http://192.168.0.106:8080/user/books/' + getUserID(token).toString(),
      headers: <String, String>{
        'Authorization' : 'Bearer $token'
      });
  return compute(parseBooks, response.body);
}

List<Book> parseBooks(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Book>((json) => Book.fromJson(json)).toList();
}

Future<Book> createBook(String bookname, year, token) async {
  var uid = getUserID(token);
  final http.Response response = await http.post(
    'http://192.168.0.106:8080/books',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    },
    body: jsonEncode(<String, String>{
      'bookname': bookname,
      'year' : year,
      'uid' : uid.toString(),
    }),
  );

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create a book.');
  }
}


Future<Book> fetchBook(int index, token) async {
  var a = index.toString();
  final response =
  await http.get('http://192.168.0.106:8080/books/' + a,
      headers: <String, String>{
        'Authorization' : 'Bearer $token',
      });

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load book');
  }
}

Future<Book> deleteBook(int index, token) async {
  var a = index.toString();
  final http.Response response = await http.delete(
    'http://192.168.0.106:8080/books/' + a,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Book.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete book.');
  }
}

Future<Book> updateBook(bid, bookname, year, token) async {
  var a = bid.toString();
  final http.Response response = await http.put(
    'http://192.168.0.106:8080/books/' + a,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'bookname': bookname,
      'year' : year,
    }),
  );

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update book.');
  }
}
