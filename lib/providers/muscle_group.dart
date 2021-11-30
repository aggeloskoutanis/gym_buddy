import 'package:flutter/cupertino.dart';

import 'exercise.dart';

class MuscleGroup with ChangeNotifier{

  String id;
  String name;
  List<Exercise> exercises;

  MuscleGroup({required this.id, required this.name, this.exercises = const []});

  Map<String, Object> toJSON(){

    final data = {

      'group_id' : id,
      'name' : name
    };

    return data;

  }

}