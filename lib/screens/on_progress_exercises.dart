import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workouts.dart';


class OnProgressExercisesScreen extends StatefulWidget {
  const OnProgressExercisesScreen({Key? key}) : super(key: key);

  static const routeName = 'on-progress-exercises';

  @override
  _OnProgressExercisesScreenState createState() =>
      _OnProgressExercisesScreenState();
}

class _OnProgressExercisesScreenState extends State<OnProgressExercisesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: Provider.of<Workouts>(context, listen: false).getWorkouts() ,
          builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Consumer<Workouts>(builder: (ctx, workouts, ch) {

                  return ListView.builder(itemCount: workouts.items.length,
                  itemBuilder: (context, index) => Card(child:Text(workouts.items[index].workoutId),),);

            } ),)
    );
  }
}
