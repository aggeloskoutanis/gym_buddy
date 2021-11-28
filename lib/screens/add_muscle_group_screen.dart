import 'package:flutter/material.dart';

import 'package:gym_buddy/widgets/multiple_search.dart';
import '../providers/exercise.dart';

import 'package:provider/provider.dart';

import '../providers/muscle_groups.dart';

class AddMuscleGroupScreen extends StatefulWidget {
  static const routeName = '/add-muscle-group';

  const AddMuscleGroupScreen({Key? key}) : super(key: key);

  @override
  _AddMuscleGroupScreenState createState() => _AddMuscleGroupScreenState();
}

class _AddMuscleGroupScreenState extends State<AddMuscleGroupScreen> {
  final _groupNameController = TextEditingController();
  List<Exercise> _exercisesToBeSaved = [];
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            errorText:
                                _validate ? 'Group name can\'t be empty' : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            labelText: 'Group name',
                            border: const OutlineInputBorder()),
                        controller: _groupNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MultipleSearch(
                        getExercises: (List<Exercise> exercises) {
                          setState(() {
                            _exercisesToBeSaved = exercises;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _groupNameController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });

                    if (!_validate && _exercisesToBeSaved.isNotEmpty) {
                      Provider.of<MuscleGroups>(context, listen: false)
                          .checkIfGroupExists(_groupNameController.text)
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Group already exists")));
                        } else {
                          Provider.of<MuscleGroups>(context, listen: false)
                              .createNewGroup(_groupNameController.text,
                                  _exercisesToBeSaved)
                              .then((value) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Group has been created.")))
                                  });
                        }
                      });
                    } else {
                      SnackBar errorMessage = const SnackBar(
                          content: Text(
                              "Exercise list or group name should not be empty."));
                      ScaffoldMessenger.of(context).showSnackBar(errorMessage);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
