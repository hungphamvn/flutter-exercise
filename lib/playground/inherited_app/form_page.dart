import 'package:flutter/material.dart';
import 'package:hello_rectangle/playground/inherited_app/state_container.dart';

class UpdateUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
  new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
  new GlobalKey<FormFieldState<String>>();

  final User user;

  const UpdateUserScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit User Info'),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          autovalidate: false,
          child: new ListView(
            children: [
              new TextFormField(
                key: firstNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              new TextFormField(
                key: lastNameKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              new TextFormField(
                key: emailKey,
                style: Theme.of(context).textTheme.headline,
                decoration: new InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            var firstName = firstNameKey.currentState.value;
            var lastName = lastNameKey.currentState.value;
            var email = emailKey.currentState.value;

            if (firstName == '') {
              firstName = null;
            }
            if (lastName == '') {
              lastName = null;
            }
            if (email == '') {
              email = null;
            }

            container.updateUserInfo(
              firstName: firstName,
              lastName: lastName,
              email: email,
            );

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}