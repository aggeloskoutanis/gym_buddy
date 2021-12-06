import 'package:flutter/material.dart';
import 'exercise.dart';
import '../helpers/db_helper.dart';

class Exercises with ChangeNotifier {

  List<Exercise> _items = [];

  List<Exercise> get items {
    return [..._items];
  }

  Future<List> fetchAndSetExercises() async {

    final dataList = await DBHelper.fetchData('exercises');

    DBHelper.getNumberOfItems('exercises').then((value) => {});




    _items = dataList.map((item) => Exercise(id: item['id'], name: item['name'], desc: item['desc'])).toList();
    notifyListeners();

    return _items;
  }

  Future<int?> getCountOfExercises(String table) async {

    return DBHelper.getNumberOfItems('exercises');
  }


  Future<List<Exercise>> filterOutExercises(String table, String whereArg) async {

    final dataList = await DBHelper.filterOutData(table, ['id', 'name', 'desc', 'FK_muscle_group'], 'name', whereArg);

    // print(dataList);

    _items = dataList.map((item) => Exercise(id: item['id'], name: item['name'], desc: item['desc'])).toList();
    notifyListeners();

    return _items;
  }

  Future<void> insertNewExercise(onChangeValue) async {


    Map<String, Object> value = {
      'id': DateTime.now().toString(),
      'name': onChangeValue,
      'desc': onChangeValue,
    };

    await DBHelper.insert('exercises', value);

  }


}