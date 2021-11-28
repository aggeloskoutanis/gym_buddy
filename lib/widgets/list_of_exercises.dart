import 'package:flutter/material.dart';
import '../providers/exercise.dart';
import '../helpers/style_helpers.dart';
import 'package:provider/provider.dart';
import '../providers/exercises.dart';

class ListOfExercises extends StatefulWidget {

  final String onChangeValue;
  final List<Exercise> exercises;

  final Function(List<Exercise>) getCheckedOutExercises;


  const ListOfExercises({required this.onChangeValue, required this.getCheckedOutExercises,required this.exercises, Key? key}) : super(key: key);


  @override
  _ListOfExercisesState createState() => _ListOfExercisesState();
}

class _ListOfExercisesState extends State<ListOfExercises> {

  ScrollController? _scrollController;
  List<Exercise> listOfExercises = [];
  String? changedValue;
  List<bool> isSelected = [];
  List<Exercise> exercisesToReturn = [];

  @override
  initState() {

    super.initState();

    _scrollController = ScrollController();
    changedValue = widget.onChangeValue;


    listOfExercises = widget.exercises;
    listOfExercises.removeWhere((element) => !element.name.contains(changedValue!));
    isSelected = List.filled(listOfExercises.length, false);

  }

  @override
  Widget build(BuildContext context) {



    return listOfExercises.isEmpty ?
      StyleHelpers.frameContainer(
          GestureDetector(
            onTap: () {
              setState(() {
                Provider.of<Exercises>(context, listen: false)
                    .insertNewExercise(changedValue);
              });

              const SnackBar snackBar =
              SnackBar(content: Text('New exercise has been added!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Card(
              elevation: 2,
              shadowColor: Theme.of(context).primaryColor,
              child: const Padding(
                padding: EdgeInsets.only(top: 20, left: 8),
                child: Text(
                  'No exercise found! Tap here to add this exercise.',
                ),
              ),
            ),
          ),
          100,
          context)
        :
    SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StyleHelpers.frameContainer(StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listOfExercises.length,
                    itemBuilder: (ctx, i) => Card(
                      elevation: 2,
                      shadowColor: Theme.of(context).primaryColor,
                      child: CheckboxListTile(
                        autofocus: false,
                        title: Text(listOfExercises[i].name),
                        subtitle: Text(listOfExercises[i].desc),
                        onChanged: (bool? value) {
                          setState(() {
                            isSelected[i] = !isSelected[i];
                          });
                          FocusScope.of(context).unfocus();
                        },
                        value: isSelected[i],
                      ),
                    ));
              },
            ), 300, context),
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      if (isSelected[i]) {
                        exercisesToReturn.add(listOfExercises[i]);
                      }
                    }

                    widget.getCheckedOutExercises(exercisesToReturn);
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Add selected'))
          ],
        ),
      );
    }
  }


