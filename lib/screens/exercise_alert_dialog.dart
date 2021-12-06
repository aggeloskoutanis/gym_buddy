import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_buddy/widgets/list_of_exercises.dart';
import 'package:provider/provider.dart';

import '../providers/exercises.dart';
import '../providers/exercise.dart';

class ExerciseAlertDialog extends StatefulWidget {
  ExerciseAlertDialog({required this.getCheckedOutExercises, Key? key})
      : super(key: key);
  final List<Exercise> exercises = [];
  final Function(List<Exercise>) getCheckedOutExercises;

  @override
  _ExerciseAlertDialogState createState() => _ExerciseAlertDialogState();
}

class _ExerciseAlertDialogState extends State<ExerciseAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final _selectedExerciseController = TextEditingController();

  String _onChangeValue = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _selectedExerciseController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    _onChangeValue = '';

    // Start listening to changes.
    // _selectedExerciseController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: AlertDialog(
            title: const Text('Select exercises'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: _selectedExerciseController,
                  // onTap: () => showSearch(context: context, delegate: ExerciseSearch()),
                  decoration: const InputDecoration(
                      labelText: 'Search text', icon: Icon(Icons.search)),
                  onTap: () {},
                  onChanged: (value) {
                    setState(() {
                      _onChangeValue = value;
                    });
                  },
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                  initialData: Provider.of<Exercises>(context, listen: false)
                      .fetchAndSetExercises(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Consumer<Exercises>(
                              child: const Center(
                                child: Text('Got no exercises yet'),
                              ),
                              builder: (context, exercises, ch) =>
                                  exercises.items.isEmpty
                                      ? ch as Widget
                                      : ListOfExercises(
                                          onChangeValue: _onChangeValue,
                                          getCheckedOutExercises:
                                              widget.getCheckedOutExercises,
                                          exercises: exercises.items),
                            ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
