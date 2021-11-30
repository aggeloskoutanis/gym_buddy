import 'package:flutter/material.dart';
import 'package:gym_buddy/screens/workout_selection_screen.dart';
import '../providers/workouts.dart';
import '../screens/group_details_screen.dart';
import '../screens/welcome_screen.dart';
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
          ChangeNotifierProvider<MuscleGroups>(create: (context) => MuscleGroups()),
          ChangeNotifierProvider<Exercises>(create: (context) => Exercises()),
          ChangeNotifierProvider<Workouts>(create: (context) => Workouts())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              accentColor: Colors.deepOrange,
              textTheme: const TextTheme(
                      bodyText1: TextStyle(), bodyText2: TextStyle())
                  .apply(
                      bodyColor: Colors.black54, displayColor: Colors.white)),
          home: MyHomePage(),
          routes: {
            MuscleGroupScreen.routeName: (ctx) => const MuscleGroupScreen(),
            AddMuscleGroupScreen.routeName: (ctx) =>
                const AddMuscleGroupScreen(),
            GroupDetailScreen.routeName: (ctx) => const GroupDetailScreen(),
            WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
            WorkoutSelectionScreen.routeName: (ctx) => const WorkoutSelectionScreen()
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => const WelcomeScreen());
          },
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => const WelcomeScreen());
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
      WelcomeScreen(),
      MuscleGroupScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bolt),
          onPressed: () {
              Navigator.of(context).pushNamed(WorkoutSelectionScreen.routeName);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: 'My activity',
                  backgroundColor: Theme.of(context).primaryColor,
                  ),

              BottomNavigationBarItem(
                  icon: const Icon(Icons.fitness_center),
                  label: 'My groups',
                  backgroundColor: Theme.of(context).colorScheme.secondary),
            ],
          ),
        ));
  }
}
