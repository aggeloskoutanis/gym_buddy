
import 'package:flutter/material.dart';
import '../models/muscle_group.dart';
import '../helpers/db_helper.dart';
import '../models/exercise.dart';

class MuscleGroups with ChangeNotifier{

  List<MuscleGroup> _items = [];

  List<MuscleGroup> get items {

    return [..._items];

  }

  void addMuscleGroup(String pickedName, List<Exercise> exercises, ){

    final newMuscleGroup = MuscleGroup(id: DateTime.now().toString(), exercises: exercises, name: pickedName);

    newMuscleGroup.exercises = exercises;

    _items.add(newMuscleGroup);
    notifyListeners();
    DBHelper.insert('muscle_groups', {'group_id': newMuscleGroup.id, 'name': newMuscleGroup.name});


    final List<Exercise> _exercises = exercises;

    _exercises.forEach((exercise) {

      DBHelper.insert('exercises', {'id': exercise.id, 'name': exercise.name, 'FK_muscle_group' : newMuscleGroup.id});

    });


  }

  Future<void> fetchAndSetMuscleGroups() async {

    final dataList = await DBHelper.fetchData('muscle_groups');
    final exercises = await DBHelper.fetchData('exercises');

    final tempItems = dataList.map((item) => MuscleGroup(id: item['id'], name: item['name'])).toList();

    tempItems.forEach((element) {

      final tempExercises = exercises.where((oldElement) => element.id == oldElement['FK_muscle_group'].toString());

      tempExercises.forEach((exercise) {

        element.exercises.add(Exercise(id: exercise['id'], name: exercise['name'], desc: exercise['desc']),);

      });


      _items.add(element);

    });


    notifyListeners();
  }

}