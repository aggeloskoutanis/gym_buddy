import 'package:flutter/material.dart';
import 'package:gym_buddy/providers/muscle_group.dart';
import 'package:gym_buddy/providers/workouts.dart';
import 'package:gym_buddy/screens/on_progress_exercises.dart';
import '../widgets/group_item.dart';
import '../providers/muscle_groups.dart';
import 'package:provider/provider.dart';

class WorkoutSelectionScreen extends StatelessWidget {
  const WorkoutSelectionScreen({Key? key}) : super(key: key);

  static const routeName = 'workout-selection';

  @override
  Widget build(BuildContext context) {

  List<MuscleGroup> muscleGroupsId = [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.directions_run),
        onPressed: (){

          /* Registers a workout */

          Provider.of<Workouts>(context, listen: false).addWorkout(muscleGroupsId).then((value) => {

            Navigator.of(context).pushNamed(OnProgressExercisesScreen.routeName)

          });


        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: FutureBuilder(
        future: Provider.of<MuscleGroups>(context, listen: false)
            .fetchAndSetMuscleGroups(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<MuscleGroups>(
          child: const Center(child: Text('No muscle groups available')),
          builder: (context, muscleGroups, ch) => muscleGroups
              .items.isEmpty
              ? ch as Widget
              : GridView.builder(
            itemCount: muscleGroups.items.length,
            itemBuilder: (BuildContext context, int index) {

              return GroupItem(isWorkoutSelection: true, muscleGroup: muscleGroups.items[index], index: index, getSelectedGroupId: (MuscleGroup muscleGroupId) {

                if (!muscleGroupsId.contains(muscleGroupId)) {
                  muscleGroupsId.add(muscleGroupId);
                }
                else{
                  muscleGroupsId.remove(muscleGroupId);
                }
                // print('GroupId: ' + muscleGroupId);

              });

            }, gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          ),
        ),
      ),
    );
  }
}
