import 'package:flutter/material.dart';


class LoginState extends StatefulWidget {
  LoginState();

  @override
  createState() =>  _LoginState();
}


class _LoginState extends State<LoginState> {

  String errorMessage = '';

  TextStyle inputTextStyle = new TextStyle(
      fontSize: 15.0,
      height: 0.7,
      color: Colors.black
  );

  TextStyle buttonTextStyle = new TextStyle(
      fontSize: 15.0,
      height: 0.7
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal :20.0),
              children: <Widget>[
                SizedBox(height: 80.0,),
                Center(
                  child: Text(
                    'Login App',
                    style: Theme.of(context).primaryTextTheme.headline,
                  ),
                ),
                SizedBox(height: 100.0,),
                Text(
                  errorMessage ?? 'Error Message',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  style: inputTextStyle,
                  decoration: new InputDecoration(
                    labelText: "Username",
                    filled:true,
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: inputTextStyle,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    filled:true,
                  ),
                ),
                SizedBox(height: 10.0,),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: buttonTextStyle ,
                      ),
                      color: Colors.grey[200],
                      textTheme: ButtonTextTheme.normal,
                      onHighlightChanged: (var a) => {true},
                      onPressed: (){},
                    ),
                    FlatButton(
                      child: Text('Next', style: buttonTextStyle),
                      color: Colors.blue[900],
                      textColor: Colors.white,
                      textTheme: ButtonTextTheme.primary,
                      onPressed: (){},
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'Nunito',
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey[600],
        ),
        // This colors the [InputOutlineBorder] when it is selected
        primaryColor: Colors.grey[500],
        textSelectionHandleColor: Colors.green[500],
      ),
      home: LoginState(),
    );
  }
}
