import 'package:flutter/material.dart';
import 'package:gym_buddy/models/exercise.dart';
import 'package:gym_buddy/widgets/exercise_alert_dialog.dart';
import '../models/exercise.dart';
import '../helpers/style_helpers.dart';

class MultipleSearch extends StatefulWidget {
  const MultipleSearch({Key? key}) : super(key: key);

  @override
  _MultipleSearchState createState() => _MultipleSearchState();
}

class _MultipleSearchState extends State<MultipleSearch> {
  final _selectedExerciseController = TextEditingController();

  List<Exercise> _selectedExercises = [];


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

    // Start listening to changes.
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyleHelpers.frameContainer(
            ListView.builder(
                itemCount: _selectedExercises.length,
                shrinkWrap: true,
                itemBuilder: (ctx, i) => ListTile(
                      title: Text(_selectedExercises[i].name),
                      subtitle: Text(_selectedExercises[i].desc),
                    )),
            300),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                primary: Colors.grey,
              ),
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ExerciseAlertDialog(
                          getCheckedOutExercises: (List<Exercise> checkedExercises){

                            setState((){
                                _selectedExercises =   checkedExercises;
                            });

                      });

                    });
              },
              label: const Text('Add exercises'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                primary: Colors.grey,
              ),
              icon: const Icon(Icons.save),
              onPressed: () {},
              label: const Text('Add new group'),
            )
          ],
        )
      ],
    );
  }




}
