import 'package:flutter/cupertino.dart';

import 'exercise.dart';

class MuscleGroup with ChangeNotifier{

  String id;
  String name;
  List<Exercise> exercises;

  MuscleGroup({required this.id, required this.name, this.exercises = const []});



}