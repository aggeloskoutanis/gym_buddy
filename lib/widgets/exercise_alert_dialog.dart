import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercises.dart';
import '../models/exercise.dart';
import '../helpers/style_helpers.dart';

class ExerciseAlertDialog extends StatefulWidget {
  ExerciseAlertDialog({required this.getCheckedOutExercises, Key? key})
      : super(key: key);
  final List<Exercise> exercises = [];
  Function(List<Exercise>) getCheckedOutExercises;

  @override
  _ExerciseAlertDialogState createState() => _ExerciseAlertDialogState();
}

class _ExerciseAlertDialogState extends State<ExerciseAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final _selectedExerciseController = TextEditingController();

  ScrollController? _scrollController;
  var _onChangeValue;
  List<bool> _isSelected = [];

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

    _scrollController = ScrollController();
    _onChangeValue = '';

    // Start listening to changes.
    _selectedExerciseController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${_selectedExerciseController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: ConstrainedBox(

            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
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
                      // setState(() {
                      //   _loadedExercises = Provider.of<Exercises>(context, listen: false).filterOutExercises('exercises', value);
                      // });
                    },
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 15,),
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
                                        : _buildListOfExercises(exercises.items)),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildListOfExercises(table) {
    List<Exercise> tempTable = table;
    print('before : ' + tempTable.toString());
    tempTable.removeWhere((element) => !element.name.contains(_onChangeValue));
    print('after' + tempTable.toString());

    _isSelected = List.filled(tempTable.length, false);

    if (tempTable.isEmpty) {
      return StyleHelpers.frameContainer(
              GestureDetector(
                onTap: () {

                  setState(() {
                    Provider.of<Exercises>(context, listen: false)
                        .insertNewExercise(_onChangeValue);
                  });

                  const SnackBar snackBar =
                  SnackBar(content:
                          Text('New exercise has been added!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();

                },
                child: Card(
                  elevation: 2,
                  shadowColor: Theme.of(context).primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20, left: 8),
                    child:
                      Text(
                        'No exercise found! Tap here to add this exercise.' ,
                      ),
                  ),
                ),
              ),
          100,
          context);
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StyleHelpers.frameContainer(
                StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tempTable.length,
                    itemBuilder: (ctx, i) => Card(
                          elevation: 2,
                          shadowColor: Theme.of(context).primaryColor,
                          child: CheckboxListTile(
                            autofocus: false,
                            title: Text(tempTable[i].name),
                            subtitle: Text(tempTable[i].desc),
                            onChanged: (bool? value) {
                              setState(() {
                                _isSelected[i] = !_isSelected[i];
                              });
                              FocusScope.of(context).unfocus();
                            },
                            value: _isSelected[i],
                          ),
                        ));
              },
            ), 300, context),
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      if (_isSelected[i]) {
                        widget.exercises.add(tempTable[i]);
                      }
                    }

                    widget.getCheckedOutExercises(widget.exercises);
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Add selected'))
          ],
        ),
      );
    }
  }
}
