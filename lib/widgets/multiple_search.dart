import 'package:flutter/material.dart';
import 'package:gym_buddy/models/exercise.dart';
import 'package:provider/provider.dart';
import '../providers/exercises.dart';
import '../models/exercise.dart';

class MultipleSearch extends StatefulWidget {
  const MultipleSearch({Key? key}) : super(key: key);

  @override
  _MultipleSearchState createState() => _MultipleSearchState();
}

class _MultipleSearchState extends State<MultipleSearch> {
  final _selectedExerciseController = TextEditingController();

  var _onChangeValue;
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
    _selectedExerciseController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${_selectedExerciseController.text}');
  }
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        TextField(
          controller: _selectedExerciseController,
          decoration: const InputDecoration(
              labelText: 'Search text', icon: Icon(Icons.search)),
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
        StreamBuilder(
            initialData: Provider.of<Exercises>(context, listen: false).fetchAndSetExercises(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
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
                            : _buildListOfExercises(exercises.items)

            ))
      ],
    );
  }
  Widget _buildListOfExercises(table){

    List<Exercise> tempTable = table;

    print('Before :' + tempTable[0].name.toString());
    print('Change value:' + _onChangeValue);
    tempTable.removeWhere((element) => !element.name.contains(_onChangeValue) );

    print('After :' + tempTable.toString());

    return ListView.builder(
      shrinkWrap: true,
      itemCount: tempTable.length,
      itemBuilder: (ctx, i) => ListTile(
        title: Text(tempTable[i].name),
        subtitle: Text(tempTable[i].desc),
        onTap: () {
          _selectedExerciseController.text =
              tempTable[i].name;
          FocusScope.of(context).unfocus();
        },
      ),
    );


  }
}
