import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8, json;

import 'package:hello_rectangle/playground/quotes_app/quote.dart';

import 'package:http/http.dart' show Client;

class ApiService{

  String url = 'https://quotes.rest/qod.json';
  Client httpClient = new Client();

  Future<Quote> getQuote() async {
    try {
      final response = await httpClient
          .get(url, headers: {"Accept": "application/json"});

      print(response.body.toString());
      // If the call to the server was successful, parse the JSON
      final jsonData = json.decode(response.body);
      if (response.statusCode != HttpStatus.ok){
        return Quote.withError(jsonData);
      }
      else {
        return Quote.fromJson(jsonData);
      }
    }
    catch (e) {
      return Quote.withError(e.toString());
    }
  }
}
