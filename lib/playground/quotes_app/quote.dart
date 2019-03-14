
import 'package:intl/intl.dart';

class Quote {
  final String quote;
  final String author;
  final String error;
  final String background;
  final String date;

  Quote({this.error, this.quote, this.author, this.background, this.date});

  factory Quote.fromJson(Map<String, dynamic> jsonMap){
    final publishDate = new DateFormat("yyyy-MM-dd").parse(jsonMap['contents']['quotes'][0]['date']);
    return new Quote(
        author: jsonMap['contents']['quotes'][0]['author'],
        quote: jsonMap['contents']['quotes'][0]['quote'],
        background: jsonMap['contents']['quotes'][0]['background'],
        date: new DateFormat('dd/MM/yyyy').format(publishDate),
        error: ""
    );
  }

  Quote.withError(String errorValue)
      : author = null,
        quote=null,
        background=null,
        date=null,
        error = errorValue;
}
