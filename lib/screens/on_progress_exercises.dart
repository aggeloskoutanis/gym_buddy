import 'package:flutter/material.dart';
import 'package:gym_buddy/providers/exercises.dart';
import 'package:provider/provider.dart';



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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
        body: FutureBuilder(
          future: Provider.of<Exercises>(context, listen: false).getWorkoutsExercises() ,
          builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Consumer<Exercises>(builder: (ctx, exercises, ch) {

                  return ListView.builder(itemCount: exercises.fetchedExercises.length,
                  itemBuilder: (context, index) =>
                      Card(child:Text(exercises.fetchedExercises[index].name),),);

            } ),)
    );
  }
}
