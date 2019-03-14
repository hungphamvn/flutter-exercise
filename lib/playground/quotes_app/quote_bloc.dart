import 'package:rxdart/rxdart.dart';
import 'package:hello_rectangle/playground/quotes_app/api_services.dart';
import 'package:hello_rectangle/playground/quotes_app/quote.dart';

class QuoteBloc {
  final _repository = ApiService();
  final _moviesFetcher = PublishSubject<Quote>();

  Observable<Quote> get singleQuote => _moviesFetcher.stream;

  fetchQuote() async {
    Quote itemModel = await _repository.getQuote();
    print(itemModel);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = QuoteBloc();