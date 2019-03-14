import 'package:flutter/material.dart';
import 'package:hello_rectangle/playground/inherited_app/state_container.dart';
import 'package:hello_rectangle/playground/inherited_app/form_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  User user;

  Widget get _userInfo {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text("${user.firstName} ${user.lastName}",
              style: new TextStyle(fontSize: 24.0)),
          new Text(user.email, style: new TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }

  Widget get _logInPrompt {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text('Please add user information'),
        ],
      ),
    );
  }

  void _updateUser(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new UpdateUserScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    user = container.user;
    var body = user != null ? _userInfo : _logInPrompt;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body: body,
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _updateUser(context),
        child: new Icon(Icons.edit),
      ),
    );
  }
}