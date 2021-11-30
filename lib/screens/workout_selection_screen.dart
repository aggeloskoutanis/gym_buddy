import 'package:flutter/material.dart';
import '../widgets/group_item.dart';
import '../providers/muscle_groups.dart';
import 'package:provider/provider.dart';

class WorkoutSelectionScreen extends StatelessWidget {
  const WorkoutSelectionScreen({Key? key}) : super(key: key);

  static const routeName = 'workout-selection';

  @override
  Widget build(BuildContext context) {

  List<String> muscleGroupsId = [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.directions_run),
        onPressed: (){

          /* Registers a workout */

          print(muscleGroupsId);

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

              return GroupItem(muscleGroup: muscleGroups.items[index], index: index, getSelectedGroupId: (String muscleGroupId) {

                muscleGroupsId.add(muscleGroupId);
                print('GroupId: ' + muscleGroupId);

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
