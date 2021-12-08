import 'package:flutter/material.dart';
import 'package:gym_buddy/providers/workouts.dart';
import 'exercise.dart';
import '../helpers/db_helper.dart';
import 'package:intl/intl.dart';

class Exercises with ChangeNotifier {

  List<Exercise> _items = [];
  List<Exercise> _fetchedExercises = [];


  List<Exercise> get fetchedExercises {
    return [..._fetchedExercises];
  }
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



  Future<List<Exercise>?> getWorkoutsExercises() async {

    List<Map<String, dynamic>>  workouts = [];
    List<Workout> temp = [];
    List<Map<String, dynamic>> exercises;

    // DBHelper.fetchWorkoutsFromDB().then((value) {
    //   exercises = value;
    //   DateTime today = DateTime.now();
    //
    //   for (var workout in exercises) {
    //     workouts.add(Workout(
    //         workoutId: workout['workout_id'],
    //         date: workout['date'],
    //         muscleGroups: workout['FK_muscle_group']));
    //   }
    //
    //   workouts.retainWhere((workout) => DateFormat('yMMMd').format(DateTime.parse(workout.date)) == DateFormat('yMMMd').format(today));
    //
    //   List<Exercise> exercisesToReturn = [];
    //
    //   for (var workout in workouts) {
    //     DBHelper.fetchExercisesOfAWorkout(workout.muscleGroups).then((fetchedExercises) {
    //
    //       for (var exercise in fetchedExercises) {
    //         exercisesToReturn.add(Exercise(
    //             id: exercise['id'],
    //             desc: exercise['desc'],
    //             name: exercise['name']));
    //       }
    //
    //       return exercisesToReturn;
    //     });
    //   }
    //
    //
    //
    // });

    workouts = await DBHelper.fetchWorkoutsFromDB();


    DateTime today = DateTime.now();

    for (var workout in workouts) {
      temp.add(Workout(
          workoutId: workout['workout_id'],
          date: workout['date'],
          muscleGroups: workout['FK_muscle_group']));
    }

    temp.retainWhere((workout) => DateFormat('yMMMd').format(DateTime.parse(workout.date)) == DateFormat('yMMMd').format(today));

    for (var workout in temp) {

      exercises = await DBHelper.fetchExercisesOfAWorkout(workout.muscleGroups);

      for (var exercise in exercises) {
        _fetchedExercises.add(Exercise(
            id: exercise['id'],
            desc: exercise['desc'],
            name: exercise['name']));
      }

    }


    notifyListeners();

    return _fetchedExercises;
  }


}