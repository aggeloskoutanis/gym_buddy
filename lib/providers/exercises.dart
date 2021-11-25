import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../helpers/db_helper.dart';

class Exercises with ChangeNotifier {

  List<Exercise> _items = [];

  List<Exercise> get items {
    return [..._items];
  }

  Future<List> fetchAndSetExercises() async {

    final dataList = await DBHelper.fetchData('exercises');

    DBHelper.getNumberOfItems('exercises').then((value) => print('Number of items is: ' +  value.toString()));




    _items = dataList.map((item) => Exercise(id: item['id'], name: item['name'], desc: item['desc'])).toList();
    notifyListeners();

    return _items;
  }

}