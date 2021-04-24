import 'package:http/http.dart';
import 'dart:convert';

Future<String> loginUser(String email, String pass) async {
  String url = 'http://192.168.0.106:8080/login/';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"email": "'+email+'", "pass": "'+pass+'"}';
  var response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;

  // final cookies = response.headers.map['set-cookie'];
  if (statusCode == 200){
    Map<String, dynamic> user = jsonDecode(response.body);
    return Future.value(user["token"]);
  } else {
    throw new Exception("Unauthorized");
  }
}