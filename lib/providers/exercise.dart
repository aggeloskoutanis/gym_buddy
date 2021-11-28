import 'package:flutter/material.dart';

class Exercise with ChangeNotifier{

  String id;
  String name;
  String desc;

  Exercise ({required this.id, required this.name, required this.desc});
}