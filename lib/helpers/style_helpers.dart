import 'package:flutter/material.dart';

class StyleHelpers {

  static Widget frameContainer(Widget child, double height, context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(10),
        height: height,
        width: 400,
        child: child);
  }

}