
import 'package:flutter/material.dart';
import 'muscle_group.dart';
import '../helpers/db_helper.dart';
import 'exercise.dart';
import 'package:logging/logging.dart';


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


    _items.clear();
    final dataList = await DBHelper.fetchData('muscle_groups');
    final exercises = await DBHelper.fetchData('exercises');

    List<Exercise> groupExercises = [];
    List<MuscleGroup> muscleGroups = [];

    dataList.forEach((group) {

      final tempExercises = exercises.where((oldElement) => group['group_id'] == oldElement['FK_muscle_group'].toString());

      tempExercises.forEach((ex) {
        groupExercises.add(Exercise(id: ex['id'], name: ex['name'], desc: ex['desc']));
      });

      muscleGroups.add(MuscleGroup(id: group['group_id'], name: group['name'], exercises: [...groupExercises]));
      groupExercises.clear();
    });


      _items = muscleGroups;

    // });


    notifyListeners();
  }

  Future<bool> checkIfGroupExists(String name) async {

    final found = await DBHelper.checkIfExists('muscle_groups', name, ['group_id', 'name']);

    return found;
  }

  Future<void> createNewGroup(String name, List<Exercise> groupExercises) async {
    
    List<String> exercisesToBeAttached = [];

    for (var element in groupExercises) {

      exercisesToBeAttached.add(element.id);

    }

    MuscleGroup newMuscleGroup = MuscleGroup(id: DateTime.now().toString(), name: name, exercises: groupExercises);

    _items.add(newMuscleGroup);

    notifyListeners();

    final data = {

      'group_id' : newMuscleGroup.id,
      'name' : newMuscleGroup.name
    };


    await DBHelper.insert('muscle_groups', data).then((value) => {


      attachExercisesToGroup(exercisesToBeAttached, data['group_id'])


    });

  }

  Future<void> attachExercisesToGroup(List<String> exercisesToAttach, String? data) async {

    final log = Logger('attachExercisesToGroup');

    final updatedRows = DBHelper.attachExercisesToGroup(exercisesToAttach, data);

    log.warning('updated rows: ' + updatedRows.toString());
  }

  MuscleGroup findById(String groupId) {

    return _items.firstWhere((muscleGroup) => muscleGroup.id == groupId);

  }

}