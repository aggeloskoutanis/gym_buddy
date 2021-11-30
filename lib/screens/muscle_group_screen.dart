import 'package:flutter/material.dart';
import 'package:gym_buddy/screens/add_muscle_group_screen.dart';
import 'package:gym_buddy/widgets/group_item.dart';
import 'package:provider/provider.dart';

import '../providers/muscle_groups.dart';

class MuscleGroupScreen extends StatefulWidget {
  const MuscleGroupScreen({Key? key}) : super(key: key);

  static const routeName = 'muscle-groups';

  @override
  State<MuscleGroupScreen> createState() => _MuscleGroupScreenState();
}

class _MuscleGroupScreenState extends State<MuscleGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddMuscleGroupScreen.routeName);
            },
          )
        ],
      ),
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

                          return GroupItem(muscleGroup: muscleGroups.items[index], index: index, getSelectedGroupId: (String _){},);

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
