import 'package:flutter/material.dart';
import '../providers/exercise.dart';
import '../providers/exercises.dart';
import '../providers/workouts.dart';
import '../widgets/workout_expandable_card.dart';
import 'package:provider/provider.dart';

class OnProgressExercisesScreen extends StatefulWidget {
  const OnProgressExercisesScreen({Key? key}) : super(key: key);

  static const routeName = 'on-progress-exercises';

  @override
  _OnProgressExercisesScreenState createState() =>
      _OnProgressExercisesScreenState();
}

class _OnProgressExercisesScreenState extends State<OnProgressExercisesScreen> {
  List<Exercise> _fetchedExercises = [];

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    final workoutsList = Provider.of<Workouts>(context).items;
    Provider.of<Exercises>(context, listen: false)
        .getWorkoutsExercises(workoutsList);
    _fetchedExercises =
        Provider.of<Exercises>(context, listen: false).fetchedExercises;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: (StreamBuilder(
          initialData: _fetchedExercises,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : Consumer<Exercises>(builder: (ctx, exercises, ch) {
                      return ReorderableListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: exercises.fetchedExercises.length,
                        onReorder: (int oldIndex, int newIndex) async {

                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }

                            if (newIndex > exercises.fetchedExercises.length) {
                              newIndex = exercises.fetchedExercises.length;
                            }
                            setState(() {
                              final Exercise item =
                                  _fetchedExercises[oldIndex];
                              _fetchedExercises.removeAt(oldIndex);
                              _fetchedExercises.insert(newIndex, item);

                          });
                        },
                        itemBuilder: (context, index) => WorkoutExpandableCard(
                          key: ValueKey(exercises.fetchedExercises[index]),
                          exercise: exercises.fetchedExercises[index],
                        ),
                      );
                    }),
        )));
  }
}
