import 'package:flutter/cupertino.dart';
import 'package:gym_buddy/helpers/db_helper.dart';
import 'package:gym_buddy/providers/muscle_group.dart';
import 'package:intl/intl.dart';


class Workout with ChangeNotifier {
  final String workoutId;
  final String date;
  final String muscleGroups;

  Workout(
      {required this.workoutId,
      required this.date,
      required this.muscleGroups});

  Map<String, Object> toJSON(String mgKey) {
    final data = {
      'workout_id': workoutId,
      'date': date,
      'FK_muscle_group': mgKey
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
    for (var muscleGroup in muscleGroups) {
      final newWorkout = Workout(
          workoutId: DateTime.now().toString(),
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          muscleGroups: muscleGroup.id);

      _items.add(Workout(
          workoutId: DateTime.now().toString(),
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          muscleGroups: muscleGroup.id));
      notifyListeners();
      DBHelper.insert('workouts', newWorkout.toJSON(muscleGroup.id))
          .catchError((onError) {
        throw Exception("Failed inserting new workout on DB");
      });
    }
  }


}
