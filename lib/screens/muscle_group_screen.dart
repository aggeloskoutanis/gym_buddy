import 'package:flutter/material.dart';
import 'package:gym_buddy/screens/add_muscle_group_screen.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../models/muscle_group.dart';
import '../providers/muscle_groups.dart';

class MuscleGroupScreen extends StatelessWidget {

  const MuscleGroupScreen({Key? key}) : super(key: key);

  String _printGroupExercises(List<Exercise> exercises) {
    String toReturn = '';

    for (var exercise in exercises) {
      toReturn = toReturn + exercise.name + ', ';
    }

    return toReturn.substring(0, toReturn.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
         IconButton(icon: const Icon(Icons.add),
           onPressed: () {
           Navigator.of(context).pushNamed(AddMuscleGroupScreen.routeName);
         },)
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<MuscleGroups>(context, listen: false)
            .fetchAndSetMuscleGroups(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<MuscleGroups>(
                    child: const Center(child: Text('No muscle groups available')),
                    builder: (context, muscleGroups, ch) => muscleGroups.items.isEmpty
                            ? ch as Widget
                            : ListView.builder(
                                itemCount: muscleGroups.items.length,
                                itemBuilder: (ctx, index) => ListTile(
                                  leading: const Icon(Icons.fitness_center),
                                  title: Text(muscleGroups.items[index].name),
                                  subtitle: Text(_printGroupExercises(
                                      muscleGroups.items[index].exercises)),
                                  onTap: () {

                                  },
                                ),
                              ) ,
                  ),
      ),
    );
  }
}
