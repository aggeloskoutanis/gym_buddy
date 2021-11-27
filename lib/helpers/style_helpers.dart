import 'package:flutter/material.dart';

class StyleHelpers {

  static Widget frameContainer(Widget child, double height) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: height,
        width: 400,
        child: child);
  }

}