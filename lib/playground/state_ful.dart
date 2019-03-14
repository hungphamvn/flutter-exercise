import 'package:flutter/material.dart';


// State ful widget
class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter++;
          this.setState(() {this._counter = _counter; });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
