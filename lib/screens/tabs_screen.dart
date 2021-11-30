import 'package:flutter/material.dart';
import 'package:gym_buddy/screens/muscle_group_screen.dart';
import 'package:gym_buddy/widgets/workout.dart';
import '../screens/welcome_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _pageIndex =0;
  PageController? _pageController;
  final List<Widget> _pages = [

  WelcomeScreen() ,
  MuscleGroupScreen()

  ];


  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        selectedItemColor: Colors.black87,
        currentIndex: _pageIndex,
        items:  [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'My activity',
              backgroundColor: Theme.of(context).primaryColor),

          BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center),
              label: 'My workouts',
              backgroundColor: Theme.of(context).colorScheme.secondary),
        ],
      ),
        body: PageView(
            children: _pages,
            onPageChanged: onPageChanged,
            controller: _pageController,
    )
    );
  }


  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController!.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}
