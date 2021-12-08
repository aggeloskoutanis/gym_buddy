import 'package:flutter/material.dart';
import 'package:gym_buddy/providers/exercise.dart';
import 'package:gym_buddy/screens/exercise_alert_dialog.dart';
import '../providers/exercise.dart';
import '../helpers/style_helpers.dart';

class MultipleSearch extends StatefulWidget {

  final Function(List<Exercise>) getExercises;

  const MultipleSearch({required this.getExercises, Key? key}) : super(key: key);



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
    _selectedExercises.isEmpty ? const Center(child: Text('Exercises list is empty = ('),):
            ListView.builder(
              itemCount: _selectedExercises.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) => Card(
                elevation: 2,
                shadowColor: Theme.of(context).primaryColor,
                child: ListTile(
                  title: Text(_selectedExercises[i].name),
                  subtitle: Text(_selectedExercises[i].desc),
                ),
              ),
            ),
            MediaQuery.of(context).size.height * 0.45, context),
            ElevatedButton(
            
            style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ExerciseAlertDialog(getCheckedOutExercises:
                        (List<Exercise> checkedExercises) {
                      setState(() {
                        _selectedExercises = checkedExercises;
                        widget.getExercises(checkedExercises);
                      });
                    });
                  });
            }, child: const Text('Add exercises', style: TextStyle(color: Colors.white,),)
          ),
      ],
    );
  }
}
