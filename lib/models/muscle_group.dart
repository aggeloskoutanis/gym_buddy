import './exercise.dart';

class MuscleGroup {

  String id;
  String name;
  List<Exercise> exercises;

  MuscleGroup({required this.id, required this.name, this.exercises = const []});



}