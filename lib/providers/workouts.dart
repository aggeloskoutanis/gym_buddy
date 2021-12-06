import 'package:flutter/cupertino.dart';
import 'package:gym_buddy/helpers/db_helper.dart';
import 'package:gym_buddy/providers/muscle_group.dart';
import 'package:intl/intl.dart';

class Workout with ChangeNotifier {


  final String workoutId;
  final String date;
  final List<MuscleGroup> muscleGroups;

  Workout({required this.workoutId, required this.date, this.muscleGroups = const []});

  Map<String, Object> toJSON(String mgKey){

    final data = {

      'workout_id' : workoutId,
      'date' : date,
      'FK_muscle_group' : mgKey

    };

    return data;
  }
}

class Workouts with ChangeNotifier {

  final List<Workout> _items = [];

  List<Workout> get items {

    return [..._items];

  }

 Future<void> addWorkout(List<MuscleGroup> muscleGroups) async {

    final newWorkout = Workout(workoutId: DateTime.now().toString() ,date: DateTime.now().toIso8601String(), muscleGroups: muscleGroups);

    _items.add(newWorkout);
    notifyListeners();


    for (var muscleGroupId in muscleGroups) {

      DBHelper.insert('workouts', newWorkout.toJSON(muscleGroupId.id)).catchError((onError) {

        throw Exception("Failed inserting new workout on DB");

      });

    }



  }

  Future<List<Workout>> getWorkouts() async {

    DateTime today = DateTime.now();
    var _today =  DateTime.parse(today.toString());
    items.retainWhere((workout) =>

      DateFormat.yMMMd().format(DateFormat('yMMMd').parse(workout.date)) == DateFormat.yMMMd().format(today)

    );
    return items;
  }



}