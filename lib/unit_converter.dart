// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:hello_rectangle/category.dart';

import 'package:hello_rectangle/unit.dart';
import 'package:hello_rectangle/api.dart';

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class UnitConverter extends StatefulWidget {
  /// Units for this [Category].

  final Category category;

  /// This [UnitConverter] requires the name, color, and units to not be null.
  const UnitConverter({
    @required this.category,
  }) : assert(category != null);

  @override
  createState() => _UnitConverterState();
}

// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
String _format(double conversion) {
  var outputNum = conversion.toStringAsPrecision(7);
  if (outputNum.contains('.') && outputNum.endsWith('0')) {
    var i = outputNum.length - 1;
    while (outputNum[i] == '0') {
      i -= 1;
    }
    outputNum = outputNum.substring(0, i + 1);
  }
  if (outputNum.endsWith('.')) {
    return outputNum.substring(0, outputNum.length - 1);
  }
  return outputNum;
}

class _UnitConverterState extends State<UnitConverter> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;

  bool _isShowError = false;

  @override
  void initState() {
    // initState
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(UnitConverter old) {
    super.didUpdateWidget(old);
    // We update our [DropdownMenuItem] units when we switch [Categories].
    if (old.category != widget.category) {
      _createDropdownMenuItems();
      _setDefaults();
    }
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.category.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }

    setState(() {
      _unitMenuItems = newItems;
    });
  }

  /// Sets the default values for the 'from' and 'to' [Dropdown]s.
  void _setDefaults() {
    setState(() {
      _fromValue = widget.category.units[0];
      _toValue = widget.category.units[1];
    });
  }

  Unit _getUnit(String unitName) {
    return widget.category.units.firstWhere(
          (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateConversion() async {
    if (widget.category.categoryName == 'Currency') {
      final double result =  await Api().convert(widget.category.categoryName.toLowerCase(),
          _inputValue.toString(), _fromValue.name.toString(), _toValue.name.toString());
      if (result ==  null){
        setState(() {
          _isShowError = true;
        });
      }
      _convertedValue = _format(result);
    }
    else {
      _convertedValue = _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    }
    setState(()
      {_convertedValue=_convertedValue;}
    );
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
            ),
          ),
        ),
      ),
    );
  }

  Widget _converter() {
    return ListView(children: <Widget>[
      TextField(
        keyboardType: TextInputType.number,
        style: Theme
            .of(context)
            .textTheme
            .display1,
        decoration: new InputDecoration(
          labelText: "Input",
          errorText:
          _showValidationError ? 'Invalid number entered' : null,
          border: new OutlineInputBorder(
            borderSide: new BorderSide(width: 2.0, color: Colors.white),
          ),
        ),
        onChanged: _updateInputValue,
      ),
      _createDropdown(_fromValue.name, _updateFromConversion),
      Container(
          child: RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              icon: Icon(Icons.compare_arrows),
              tooltip: 'Convert',
              onPressed: null,
              iconSize: 40.0,
            ),
          )),
      InputDecorator(
        child: Text(
          _convertedValue,
          style: Theme
              .of(context)
              .textTheme
              .display1,
        ),
        decoration: InputDecoration(
          labelText: 'Output',
          labelStyle: Theme
              .of(context)
              .textTheme
              .display1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
      _createDropdown(_toValue
          .
      name
          ,
          _updateToConversion
      )
      ,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    final error = Text(
      'Oops'
    );
    // Here is just a placeholder for a list of mock units
    if(widget.category.units == null || (widget.category.categoryName =='Currency' && _isShowError)) {
      return error;
    }else{
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxHeight == constraints.maxWidth) {
                return _converter();
              } else {
                return Center(
                    child: Container(
                        width: 450.0,
                        child: _converter()
                    )
                );
              }
            }
        ),
      );
    }
  }
}
