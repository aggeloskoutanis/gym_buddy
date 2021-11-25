import 'package:flutter/material.dart';
import '../providers/exercises.dart';
import '../providers/muscle_groups.dart';
import 'package:provider/provider.dart';
import './screens/add_muscle_group_screen.dart';
import './screens/muscle_group_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MuscleGroups>(
            create: (context) => MuscleGroups()),
        ChangeNotifierProvider<Exercises>(
            create: (context) => Exercises())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MuscleGroupScreen(),
        routes: {
          AddMuscleGroupScreen.routeName : (ctx) => const AddMuscleGroupScreen()


        })
    );
  }

}
