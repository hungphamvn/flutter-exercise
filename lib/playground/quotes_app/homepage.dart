import 'package:flutter/material.dart';
import 'package:hello_rectangle/playground/quotes_app/quote.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../quotes_app/quote_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}

class QuoteTile extends StatelessWidget {
  QuoteTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchQuote();
    return new Center(
        child: new StreamBuilder(
            stream: bloc.singleQuote,
            //sets the getQuote method as the expected Future
            builder: (context, AsyncSnapshot<Quote> snapshot) {
              if (snapshot.hasData && snapshot.data.quote != null) {
                return Column(
                  children: [
//                    snapshot.data.background ?? new Image(image: new CachedNetworkImageProvider(snapshot.data.background)),
                    Center(
                      child: Text(
                        '" ${snapshot.data.quote} "',
                        style: Theme.of(context).primaryTextTheme.title,
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Text(
                            "${snapshot.data.date} - ${snapshot.data.author}",
                            style: Theme.of(context).primaryTextTheme.body1,
                          ),
                        )
                  ],
                );
              } else if (snapshot.data.error != null) {
                //checks if the response throws an error
                return Text("${snapshot.data.error}");
              }
              return CircularProgressIndicator();
            }
        )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Be Motivate Every Day'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8.0),
        child: Container(
          padding: new EdgeInsets.only(top: 16.0),
          child: QuoteTile(),
        ),
      ),
    );
  }
}

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Nunito',
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.transparent,
                displayColor: Colors.grey[600],
              ),
          // This colors the [InputOutlineBorder] when it is selected
          primaryColor: Colors.grey[500],
          textSelectionHandleColor: Colors.green[500],
        ),
        home: HomePage());
  }
}
