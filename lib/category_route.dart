// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:hello_rectangle/category_tile.dart';
import 'package:hello_rectangle/category.dart';
import 'package:hello_rectangle/unit.dart';
import 'package:hello_rectangle/unit_converter.dart';
import 'package:hello_rectangle/backdrop.dart';
import 'package:hello_rectangle/api.dart';


final _backgroundColor = Colors.green[100];


class CategoryRoute extends StatefulWidget {
  CategoryRoute();

  @override
  createState() => _CategoryState();
}

class _CategoryState extends State<CategoryRoute> {
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;

  // from above. Use a placeholder icon, such as `Icons.cake` for each
  // Category. We'll add custom icons later.
//  @override
//  void initState() {
//    super.initState();
//    for (var i = 0; i < _categoryNames.length; i++) {
//      var category = Category(
//        categoryName: _categoryNames[i],
//        categoryIcon: Icons.cake,
//        categoryColor: _baseColors[i],
//        units: _retrieveUnitList(_categoryNames[i]),
//      );
//
//      if (i == 0) {
//        _defaultCategory = category;
//      }
//      _categories.add(category);
//    }
//  }

//  We use didChangeDependencies() so that we can
//   wait for our JSON asset to be loaded in (async).
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our
    // assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
      await _retrieveApiCategory();
    }
  }

  static const _baseIcons = [
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png'
  ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var _category = _categories[index];
          return CategoryTile(
            category: _categories[index],
            onTap: _category.categoryName == 'Currency' &&
                _category.units.isEmpty
                ? null
                : _onCategoryTap,
          );
        },
        itemCount: _categories.length,
      );
    }
    else {
      return GridView.count(
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
        crossAxisCount: 2,
        childAspectRatio: 3.0,
      );
    }
  }

  Future<void> _retrieveApiCategory() async {
    const name = 'Currency';
    final List<dynamic> data = await Api().getUnits('currency');
    var category = Category(
      categoryName: name,
      units: [],
      categoryColor: _baseColors.last,
      categoryIcon: _baseIcons.last,
    );

    if (data != null) {
      final List<Unit> units = data.map<Unit>(
              (dynamic data) => Unit.fromJson(data)).toList();

      category = Category(
          categoryName: name,
          units: units,
          categoryColor: _baseColors.last,
          categoryIcon: _baseIcons.last
      );
    }
    setState(() {
      _categories.add(category);
    });
  }

  /// Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    // Consider omitting the types for local variables. For more details on Effective
    // Dart Usage, see https://www.dartlang.org/guides/language/effective-dart/usage
    final json = DefaultAssetBundle
        .of(context)
        .loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    var categoryIndex = 0;
    for (var key in data.keys) {
      if (data is! Map) {
        throw ('Data retrieved from API is not a Map');
      }

      final List<Unit> units = data[key].map<Unit>(
              (dynamic data) => Unit.fromJson(data)).toList();

      var category = Category(
          categoryName: key,
          units: units,
          categoryColor: _baseColors[categoryIndex],
          categoryIcon: _baseIcons[categoryIndex]
      );

      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex += 1;
    }
  }

  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    // list view of the Categories
    assert(debugCheckHasMediaQuery(context));
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: _buildCategoryWidgets(MediaQuery
            .of(context)
            .orientation),
      ),
    );

    return Backdrop(
      currentCategory: _currentCategory == null
          ? _defaultCategory
          : _currentCategory,
      frontPanel: _currentCategory == null
          ? UnitConverter(category: _defaultCategory)
          : UnitConverter(category: _currentCategory),
      frontTitle: Text("Unit Converter"),
      backTitle: Text("Select Category"),
      backPanel: listView,
    );
  }
}
