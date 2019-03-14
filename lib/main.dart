// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hello_rectangle/category_route.dart';

// Name navigator
import 'package:hello_rectangle/playground/name_navigator.dart';
import 'package:hello_rectangle/playground/returning_data.dart';
import 'package:hello_rectangle/playground/non_material.dart';
import 'package:hello_rectangle/playground/rating_screen.dart';
import 'package:hello_rectangle/playground/contract_demo.dart';

import 'package:hello_rectangle/playground/quotes_app/homepage.dart';

import 'package:hello_rectangle/playground/login_app/login_screen.dart';

void main() {
  runApp(LoginApp());
}

class RatingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuoteApp();
  }
}
//
//class HomeScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Rating'),
//        backgroundColor: Colors.blue[100],
//      ),
//      body: mainPage,
//    );
//  }
//}


 /* This for Udacity Converter course app
 - Load category of unit from local json file
 - Load Currency category from api

  */

//class ConvertedApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Unit Converter',
//      theme: ThemeData(
//        fontFamily: 'Nunito',
//        textTheme: Theme.of(context).textTheme.apply(
//          bodyColor: Colors.black,
//          displayColor: Colors.grey[600],
//        ),
//        // This colors the [InputOutlineBorder] when it is selected
//        primaryColor: Colors.grey[500],
//        textSelectionHandleColor: Colors.green[500],
//      ),
//      home:  CategoryRoute()
//    );
//  }
//}
